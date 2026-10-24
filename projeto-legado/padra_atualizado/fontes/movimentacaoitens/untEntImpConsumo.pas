unit untEntImpConsumo;

interface

uses
  untPesqAux,
  Uni,
  untZClient,
  Vcl.Controls,
  System.SysUtils,
  System.Classes,
  Data.DB,
  Datasnap.DBClient,
  untFuncoesSimples,
  untTypesSistema,
  cxProgressBar,
  untXMLConsumo,
  untXMLConsumoItem,
  System.Variants,
  System.Generics.Collections,
  System.StrUtils,
  System.DateUtils,
  untTBanCtpRepository,
  untPcmGer,
  untMovBan,
  untCadPag,
  untCadFis,
  untConstantes,
  untDuplicatas,
  untFuncoes;

type

  TEntImpConsumo = class(TComponent)
  private
    { Parâmetros de Configuração da Importação (Variáveis de Controle com prefixo de tipo) }
    FblnUSACTF: Boolean;
    FblnSimPau: Boolean;
    FstrAutIncCadFis: String;
    FarrLinDigCodbar: TarrLinDigCodbar;
    FarrDuplicata: TarrDuplicata;
    FstrCodigoEmpresa: String;
    FstrCodigoOperador: String;
    FstrCodigoPortador: String;
    FstrCodigoEvento: String;
    FstrCodigoConta: String;
    FstrCondicaoPagamento: String;
    FdtaDataEntrada: TDateTime;
    FblnGerarContasAPagar: Boolean;
    FcdsAbrPis: TZClient;
    FcdsAbrCof: TZClient;
    FstlListaCFOP: TStringList;
    FblnUSACND: Boolean;
    FblnImportarSemVencimento: Boolean;
    procedure pConfigurarDataSet;
    function fValidarRegistroIndividual: Boolean;
    function fCFOPConsumo(const AstrCFOPXML: String): String;
    procedure pCalculaPisCofins;
    procedure pGravarCadFis;
    procedure pGravarCadPag;
    procedure pCriaMovGerMovDet;
    function fGerarHistoricoCTP: String;
    function fMontaDuplicatasXML: Boolean;
    function fVerificaTemCadPag(AstrParcela: String): Boolean;
    function fSimples: Boolean;
    function fConsultarConta: Boolean;
    function fCarregaAbrevPisCofPrg(prgProgresso: TcxProgressBar): Boolean;
    procedure pConsultarAbreviacaoCOFINS;
    procedure pConsultarAbreviacaoPIS;
    function fSelecionaAbreviacaoPisCOFINS(AstrTipo: String;
      AcdsPISCOFINS: TZClient; out AcurAliquota: Currency; out AstrCST: String;
      out AcurBase: Currency; out AblnTodos: Boolean): Boolean;
    procedure pAtualizarAbreviacaoCOFINS(AcurAliquota: Double; AcurBase: Double; AstrCST: String);
    procedure pAtualizarAbreviacaoPIS(AcurAliquota: Double; AcurBase: Double; AstrCST: String);
    procedure pProcessarTributacaoCOFINS(const pCFOP: String);
    procedure pProcessarTributacaoPIS(const pCFOP: String);
    function fDefineCndPag(const AstrCodFor: String): String;
    function fRetornarCondicaoPagamentoXMl: String;
    function fNormalizarCodEnergiaEletrica(const AstrValor: String; AintMinimo,
      AintMaximo: Integer): String;
    procedure pGravarXmlImportado;
  public
    qryTabela: TClientDataSet;
    dtsTabela: TDataSource;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    { Métodos de Configuração (Fluent Interface) }
    function fCodigoEmpresa(AValor: String): TEntImpConsumo;
    function fCodigoOperador(AValor: String): TEntImpConsumo;
    function fCodigoPortador(AValor: String): TEntImpConsumo;
    function fCodigoEvento(AValor: String): TEntImpConsumo;
    function fCodigoConta(AValor: String): TEntImpConsumo;
    function fCondicaoPagamento(AValor: String): TEntImpConsumo;
    function fImportarSemVencimento(AValor: Boolean): TEntImpConsumo;
    function fDataEntrada(AValor: TDateTime): TEntImpConsumo;
    function fGerarContasAPagar(AValor: Boolean): TEntImpConsumo;

    { ETAPA 1: Carregamento e Leitura dos Arquivos }
    function fCarregarArquivosDiretorio(strCaminho: String;
      prgProgresso: TcxProgressBar): Boolean;
    procedure pMarcarTodosRegistros(blnMarcar: Boolean);

    { ETAPA 2: Processamento e Gravação no Banco de Dados }
    function fConfirmarImportacaoConsumo(prgProgresso: TcxProgressBar): Boolean;
    procedure fAlterarStatus(AintStatus: Integer = 0; AstrMensagem: String = '');
  end;

const
  IMPORTADO_COM_ERRO = 1;
  DOCUMENTO_JA_EXISTE = 2;
  COM_ERRO_GRAVACAO = 3;

implementation

uses
  untEscolhePisCofinsFrete;

{ TEntImpConsumo }

constructor TEntImpConsumo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FblnImportarSemVencimento := False;
  FblnUSACND := fCfgSis('USACND', varBoolean);
  FblnUSACTF := fCfgSis('USACTF', varBoolean);
  FblnSimPau := fCfgSis('SIMPAU', varBoolean);
  FcdsAbrPis := TZClient.Create(Self);
  FcdsAbrCof := TZClient.Create(Self);
  FstlListaCFOP := TStringList.Create;
  qryTabela := TClientDataSet.Create(Self);
  dtsTabela := TDataSource.Create(Self);
  dtsTabela.DataSet := qryTabela;

  pConfigurarDataSet;
end;

destructor TEntImpConsumo.Destroy;
begin
  pFreeAndNil(FstlListaCFOP);
  pFreeAndNil(qryTabela);
  pFreeAndNil(dtsTabela);
  pFreeAndNil(FcdsAbrCof);
  pFreeAndNil(FcdsAbrPis);
  inherited Destroy;
end;

procedure TEntImpConsumo.fAlterarStatus(AintStatus: Integer; AstrMensagem: String);
begin
  qryTabela.FieldByName('STATUS').AsString := IntToStr(AintStatus);
  qryTabela.FieldByName('MENSAGEM_STATUS').AsString := AstrMensagem;
end;

procedure TEntImpConsumo.pConfigurarDataSet;
begin
  qryTabela.Close;
  qryTabela.FieldDefs.Clear;

  { --- CAMPOS DE CONTROLE DE PROCESSO --- }
  qryTabela.FieldDefs.Add('IMPORTAR',        ftString, 1);   // S ou N
  qryTabela.FieldDefs.Add('REGISTRO_VALIDO', ftString, 1);   // S ou N
  qryTabela.FieldDefs.Add('MENSAGEM_STATUS', ftString, 1000);
  qryTabela.FieldDefs.Add('ARQUIVO',    ftString, 255);
  qryTabela.FieldDefs.Add('NOME_ARQUIVO',    ftString, 255);
  qryTabela.FieldDefs.Add('STATUS',        ftString, 1);   // S ou N
  { --- DADOS DO DOCUMENTO (IDENTIFICAÇÃO) --- }
  qryTabela.FieldDefs.Add('CHAVE_ACESSO',    ftString, 44);
  qryTabela.FieldDefs.Add('ESPECIE_DOCUMENTO', ftString, 10);
  qryTabela.FieldDefs.Add('NUMERO_DOCUMENTO',ftString, 20);
  qryTabela.FieldDefs.Add('SERIE_DOCUMENTO', ftString, 5);
  qryTabela.FieldDefs.Add('MODELO_DOCUMENTO', ftString, 2);
  qryTabela.FieldDefs.Add('DATA_EMISSAO',    ftDateTime);
  qryTabela.FieldDefs.Add('CODIGO_EMITENTE',   ftString, 10);
  qryTabela.FieldDefs.Add('CNPJ_EMITENTE',   ftString, 20);
  qryTabela.FieldDefs.Add('NOME_EMITENTE',   ftString, 100);
  qryTabela.FieldDefs.Add('ESTADO_EMITENTE',   ftString, 2);
  qryTabela.FieldDefs.Add('COMPLEMENTO',     ftString, 2000);

  qryTabela.FieldDefs.Add('CNPJ_DESTINATARIO',   ftString, 20);
  qryTabela.FieldDefs.Add('CODIGO_DESTINATARIO',   ftString, 10);

  { --- VALORES FINANCEIROS E TOTAIS --- }
  qryTabela.FieldDefs.Add('VALOR_TOTAL',       ftCurrency);
  qryTabela.FieldDefs.Add('BASE_ICMS',         ftCurrency);
  qryTabela.FieldDefs.Add('VALOR_ICMS',        ftCurrency);
  qryTabela.FieldDefs.Add('CST_PIS',           ftString, 2);
  qryTabela.FieldDefs.Add('ALIQUOTA_BASE_PIS',   ftCurrency);
  qryTabela.FieldDefs.Add('BASE_PIS',          ftCurrency);
  qryTabela.FieldDefs.Add('VALOR_PIS',         ftCurrency);
  qryTabela.FieldDefs.Add('ALIQUOTA_PIS',      ftCurrency);
  qryTabela.FieldDefs.Add('VALOR_PISEFET',     ftCurrency);
  qryTabela.FieldDefs.Add('CST_COFINS',        ftString, 2);
  qryTabela.FieldDefs.Add('ALIQUOTA_BASE_COFINS',   ftCurrency);
  qryTabela.FieldDefs.Add('BASE_COFINS',       ftCurrency);
  qryTabela.FieldDefs.Add('ALIQUOTA_COFINS',   ftCurrency);
  qryTabela.FieldDefs.Add('VALOR_COFINS',      ftCurrency);
  qryTabela.FieldDefs.Add('VALOR_COFINSEFET',  ftCurrency);
  qryTabela.FieldDefs.Add('VALOR_OUTROS',      ftCurrency);
  qryTabela.FieldDefs.Add('VALOR_TRIBTOT',     ftCurrency);
  qryTabela.FieldDefs.Add('DESCRICAO_SERVICO', ftString, 500);

  qryTabela.FieldDefs.Add('CFOP',              ftString, 4);

  qryTabela.FieldDefs.Add('VALOR_REIRRF',     ftCurrency);
  qryTabela.FieldDefs.Add('VALOR_RETPIS',     ftCurrency);
  qryTabela.FieldDefs.Add('VALOR_RETCOFINS',     ftCurrency);
  qryTabela.FieldDefs.Add('VALOR_RETCSLL',     ftCurrency);

  { --- DADOS DA FATURA / PAGAMENTO --- }
  qryTabela.FieldDefs.Add('COMPETENCIA',     ftString, 10);
  qryTabela.FieldDefs.Add('DATA_VENCIMENTO', ftDateTime);
  qryTabela.FieldDefs.Add('CODIGO_BARRAS',   ftString, 100);
  qryTabela.FieldDefs.Add('FATURA',          ftString, 50);
  qryTabela.FieldDefs.Add('DEBITO_AUTO',     ftString, 50);
  qryTabela.FieldDefs.Add('PIX',             ftString, 1000);
  qryTabela.FieldDefs.Add('CONDICAO_PAGAMENTO',     ftString, 60);
  qryTabela.FieldDefs.Add('CCODCONS',         ftString, 2);
  qryTabela.FieldDefs.Add('CGRUPOTENSAO',     ftString, 2);

  qryTabela.FieldDefs.Add('TOT_IBS',           ftCurrency);  // FIS_TOTIBS
  qryTabela.FieldDefs.Add('TOT_IBSUF',         ftCurrency);  // FISREF.FIS_IBSUFV (v2)
  qryTabela.FieldDefs.Add('TOT_IBSMUN',        ftCurrency);  // FISREF.FIS_IBSMNV (v2)
  qryTabela.FieldDefs.Add('TOT_CBS',           ftCurrency);  // FIS_TOTCBS
  qryTabela.FieldDefs.Add('TOT_IS',            ftCurrency);  // FIS_TOT_IS
  qryTabela.FieldDefs.Add('TOT_PROIS',         ftCurrency);  // FIS_TPROIS
  qryTabela.FieldDefs.Add('TOT_NF_RT',         ftCurrency);  // FIS_TOT_NF
  qryTabela.FieldDefs.Add('BC_IBSCBS',         ftCurrency);  // vBC do gIBSCBS somado
  qryTabela.FieldDefs.Add('BC_IS',             ftCurrency);
  qryTabela.FieldDefs.Add('RT_CST',            ftString, 3);
  qryTabela.FieldDefs.Add('RT_CCLASSTRIB',     ftString, 6);
  qryTabela.FieldDefs.Add('RT_PALIQ_IBSUF',    ftCurrency);
  qryTabela.FieldDefs.Add('RT_PALIQ_IBSMUN',   ftCurrency);
  qryTabela.FieldDefs.Add('RT_PALIQ_CBS',      ftCurrency);
  qryTabela.FieldDefs.Add('RT_CSTREG',         ftString, 3);
  qryTabela.FieldDefs.Add('RT_AIUREG',         ftCurrency);
  qryTabela.FieldDefs.Add('RT_TIUREG',         ftCurrency);
  qryTabela.FieldDefs.Add('RT_AIMREG',         ftCurrency);
  qryTabela.FieldDefs.Add('RT_TIMREG',         ftCurrency);
  qryTabela.FieldDefs.Add('RT_CBSREG',         ftCurrency);
  qryTabela.FieldDefs.Add('RT_TCBREG',         ftCurrency);
  qryTabela.FieldDefs.Add('SCE_TPPCOM',        ftString, 2);
  qryTabela.FieldDefs.Add('SCE_IDACGE',        ftString, 30);
  qryTabela.FieldDefs.Add('SCE_VPTINS',        ftCurrency);
  qryTabela.FieldDefs.Add('SCE_TPFENE',        ftString, 2);
  qryTabela.FieldDefs.Add('SCE_ENEALO',        ftCurrency);
  qryTabela.FieldDefs.Add('SCE_TPPTAR',        ftString, 2);
  qryTabela.FieldDefs.Add('SCE_ENEINJ',        ftCurrency);
  qryTabela.FieldDefs.Add('SCE_TPPINJ',        ftString, 2);
  qryTabela.FieldDefs.Add('ARQUIVO_TEXTO',    ftMemo, 10000);
  qryTabela.CreateDataSet;
end;

{ Métodos de Atribuição (Fluent Interface) }

function TEntImpConsumo.fCodigoEmpresa(AValor: String): TEntImpConsumo;
begin
  FstrCodigoEmpresa := AValor;
  Result := Self;
end;

function TEntImpConsumo.fCodigoOperador(AValor: String): TEntImpConsumo;
begin
  FstrCodigoOperador := AValor;
  Result := Self;
end;

function TEntImpConsumo.fCodigoPortador(AValor: String): TEntImpConsumo;
begin
  FstrCodigoPortador := AValor;
  Result := Self;
end;

function TEntImpConsumo.fCodigoEvento(AValor: String): TEntImpConsumo;
begin
  FstrCodigoEvento := AValor;
  Result := Self;
end;

function TEntImpConsumo.fCodigoConta(AValor: String): TEntImpConsumo;
begin
  FstrCodigoConta := AValor;
  Result := Self;
end;

function TEntImpConsumo.fCondicaoPagamento(AValor: String): TEntImpConsumo;
begin
  FstrCondicaoPagamento := AValor;
  Result := Self;
end;

function TEntImpConsumo.fDataEntrada(AValor: TDateTime): TEntImpConsumo;
begin
  FdtaDataEntrada := AValor;
  Result := Self;
end;

function TEntImpConsumo.fGerarContasAPagar(AValor: Boolean): TEntImpConsumo;
begin
  FblnGerarContasAPagar := AValor;
  Result := Self;
end;

{ --- ETAPA 1: CARREGAMENTO --- }

function TEntImpConsumo.fCarregarArquivosDiretorio(strCaminho: String;
  prgProgresso: TcxProgressBar): Boolean;
var
  LobjListaXML: TXMLManager;
  LintContador: Integer;
  LobjXML: TXMLDoc;
  LstrCFOP: String;
  LstrCNPJ: String;
begin
  Result := False;
  if not DirectoryExists(strCaminho) then
    Exit;

  LobjListaXML := TXMLManager.Create(strCaminho, True);
  try
    qryTabela.EmptyDataSet;
    if LobjListaXML.Count = 0 then
      Exit;

    if Assigned(prgProgresso) then
    begin
      prgProgresso.Properties.Max := LobjListaXML.Count;
      prgProgresso.Position := 0;
    end;

    qryTabela.DisableControls;
    try
      for LintContador := 0 to LobjListaXML.Count - 1 do
      begin
        LobjXML := LobjListaXML.Items(LintContador);
        qryTabela.Append;
        qryTabela.FieldByName('ARQUIVO_TEXTO').AsString := LobjXML.fXMLTexto;
        qryTabela.FieldByName('ARQUIVO').AsString := LobjXML.FileName;
        If Not LobjXML.Valido Then
        Begin
          qryTabela.FieldByName('NOME_ARQUIVO').AsString    := ExtractFileName(LobjXML.FileName);
          qryTabela.FieldByName('REGISTRO_VALIDO').AsString := 'N';
          qryTabela.FieldByName('IMPORTAR').AsString        := 'N';
          fAlterarStatus(IMPORTADO_COM_ERRO, 'XML inválido: ' + LobjXML.Erro);
          qryTabela.Post;
          if Assigned(prgProgresso) then
            prgProgresso.Position := prgProgresso.Position + 1;
          Continue;
        End;
        qryTabela.FieldByName('NOME_ARQUIVO').AsString := ExtractFileName(LobjXML.FileName);
        qryTabela.FieldByName('STATUS').AsString := '0';
        { Alimenta o DataSet diretamente do objeto XML }
        qryTabela.FieldByName('CHAVE_ACESSO').AsString := LobjXML.Ide.ChaveAcesso;
        qryTabela.FieldByName('NUMERO_DOCUMENTO').AsString := fStrZero(LobjXML.Ide.Numero,12);
        qryTabela.FieldByName('SERIE_DOCUMENTO').AsString := LobjXML.Ide.Serie;
        qryTabela.FieldByName('MODELO_DOCUMENTO').AsInteger := LobjXML.Modelo;

        LstrCFOP := '';
        If Assigned(LobjXML.Product(0)) Then
          LstrCFOP := LobjXML.Product(0).CFOP;

        LstrCFOP := fCFOPConsumo(LstrCFOP);
        qryTabela.FieldByName('CFOP').AsString := LstrCFOP;
        If FstlListaCFOP.IndexOf(LstrCFOP) = -1 Then
          FstlListaCFOP.Add(LstrCFOP);

        case LobjXML.Modelo of
          62:
            {Especie 'CO' so e valida quando o CFOP esta na faixa de comunicacao,
             mesma regra de TfrmCadLivroFiscal.fValidaClaFisCT.
             Verificar Nota 1 - Req. 462019}
            if Pos(LstrCFOP, CFOP_COMUNICACAO) > 0 then
              qryTabela.FieldByName('ESPECIE_DOCUMENTO').AsString := 'CO'
            else
              qryTabela.FieldByName('ESPECIE_DOCUMENTO').AsString := 'NF';
          {Modelo 66 (NF3e) e 75 (NFAg) nao possuem especie propria - caem no Else = 'NF'.
           Verificar Nota 1 - Req. 462019}
          //66: qryTabela.FieldByName('ESPECIE_DOCUMENTO').AsString := 'EL';
          //75: qryTabela.FieldByName('ESPECIE_DOCUMENTO').AsString := 'AG';
        else
          qryTabela.FieldByName('ESPECIE_DOCUMENTO').AsString := 'NF';
        end;

        If Not fEmptyStr(LobjXML.Ide.DataEmissao) Then
          qryTabela.FieldByName('DATA_EMISSAO').AsDateTime := ISO8601ToDate(Copy(LobjXML.Ide.DataEmissao,1,10));

        qryTabela.FieldByName('CNPJ_EMITENTE').AsString := LobjXML.Emit.CNPJ;
        qryTabela.FieldByName('CODIGO_EMITENTE').AsString := fRetCodFornecedorPorCnpj(qryTabela.FieldByName('CNPJ_EMITENTE').AsString);
        qryTabela.FieldByName('NOME_EMITENTE').AsString := fRetNomFornecedor(qryTabela.FieldByName('CODIGO_EMITENTE').AsString);
        qryTabela.FieldByName('ESTADO_EMITENTE').AsString := LobjXML.Emit.UF;

        LstrCNPJ := LobjXML.Dest.CNPJ;
        if fEmptyStr(LstrCNPJ) Then
          LstrCNPJ := LobjXML.Dest.IdOutros;

        qryTabela.FieldByName('CNPJ_DESTINATARIO').AsString := LstrCNPJ;
        qryTabela.FieldByName('CODIGO_DESTINATARIO').AsString := fRetEmpresaPeloCGC(qryTabela.FieldByName('CNPJ_DESTINATARIO').AsString);

        qryTabela.FieldByName('VALOR_TOTAL').AsCurrency := LobjXML.Total.ValorTotal;
        qryTabela.FieldByName('BASE_ICMS').AsCurrency := LobjXML.Total.ValorBC;
        qryTabela.FieldByName('VALOR_ICMS').AsCurrency := LobjXML.Total.ValorICMS;
        qryTabela.FieldByName('BASE_PIS').AsCurrency := LobjXML.Total.BasePis;
        qryTabela.FieldByName('ALIQUOTA_PIS').AsCurrency := LobjXML.Total.AliquotaPis;
        qryTabela.FieldByName('VALOR_PIS').AsCurrency := LobjXML.Total.ValorPIS;
        qryTabela.FieldByName('VALOR_PISEFET').AsCurrency := LobjXML.Total.ValorPISEfet;
        qryTabela.FieldByName('BASE_COFINS').AsCurrency := LobjXML.Total.BaseCOFINS;
        qryTabela.FieldByName('ALIQUOTA_COFINS').AsCurrency := LobjXML.Total.AliquotaCofins;
        qryTabela.FieldByName('VALOR_COFINS').AsCurrency := LobjXML.Total.ValorCOFINS;
        qryTabela.FieldByName('VALOR_COFINSEFET').AsCurrency := LobjXML.Total.ValorCOFINSEfet;
        qryTabela.FieldByName('VALOR_OUTROS').AsCurrency := LobjXML.Total.ValorOutros;

        qryTabela.FieldByName('VALOR_REIRRF').AsCurrency := LobjXML.Total.ValorRetIRRFAcum;
        qryTabela.FieldByName('VALOR_RETPIS').AsCurrency := LobjXML.Total.ValorRetPISAcum;
        qryTabela.FieldByName('VALOR_RETCOFINS').AsCurrency := LobjXML.Total.ValorRetCOFINSAcum;
        qryTabela.FieldByName('VALOR_RETCSLL').AsCurrency := LobjXML.Total.ValorRetCSLLAcum;

        If Assigned(LobjXML.Acessante) Then
        Begin
          qryTabela.FieldByName('CCODCONS').AsString     := LobjXML.Acessante.tpClasse;
          qryTabela.FieldByName('CGRUPOTENSAO').AsString := LobjXML.Acessante.tpGrpTensao;
        End;

        If Not fEmptyStr(LobjXML.gFat.dVencFat) Then
          qryTabela.FieldByName('DATA_VENCIMENTO').AsDateTime := ISO8601ToDate(LobjXML.gFat.dVencFat);
        qryTabela.FieldByName('CODIGO_BARRAS').AsString := LobjXML.gFat.codBarras;
        qryTabela.FieldByName('FATURA').AsString := LobjXML.gFat.nFat;
        qryTabela.FieldByName('DEBITO_AUTO').AsString := LobjXML.gFat.codDebAuto;
        qryTabela.FieldByName('PIX').AsString := LobjXML.gFat.urlQRCodePIX;
        qryTabela.FieldByName('COMPLEMENTO').AsString := LobjXML.InfCpl;
        If Not fEmptyStr(qryTabela.FieldByName('FATURA').AsString) Then
          qryTabela.FieldByName('CONDICAO_PAGAMENTO').AsString := fRetornarCondicaoPagamentoXMl;

        If fEmptyStr(qryTabela.FieldByName('CONDICAO_PAGAMENTO').AsString) And (FblnUSACND) then
          qryTabela.FieldByName('CONDICAO_PAGAMENTO').AsString :=
            fDefineCndPag(qryTabela.FieldByName('CODIGO_EMITENTE').AsString);

        If fEmptyStr(qryTabela.FieldByName('CONDICAO_PAGAMENTO').AsString) Then
          If Not fEmptyStr(FstrCondicaoPagamento) Then
            qryTabela.FieldByName('CONDICAO_PAGAMENTO').AsString := FstrCondicaoPagamento;

        qryTabela.FieldByName('TOT_IBS').AsCurrency    := LobjXML.Total.ValorIBS_Doc;
        qryTabela.FieldByName('TOT_IBSUF').AsCurrency  := LobjXML.Total.ValorIBSUF_Doc;  // v2
        qryTabela.FieldByName('TOT_IBSMUN').AsCurrency := LobjXML.Total.ValorIBSMun_Doc; // v2
        qryTabela.FieldByName('TOT_CBS').AsCurrency    := LobjXML.Total.ValorCBS_Doc;
        qryTabela.FieldByName('TOT_IS').AsCurrency     := LobjXML.Total.ValorIS_Doc;
        qryTabela.FieldByName('TOT_PROIS').AsCurrency  := LobjXML.Total.ValorProIS_Doc;
        qryTabela.FieldByName('TOT_NF_RT').AsCurrency  := LobjXML.Total.ValorNF_Doc;
        qryTabela.FieldByName('BC_IBSCBS').AsCurrency  := LobjXML.Total.BaseIBSCBS_Doc;
        qryTabela.FieldByName('BC_IS').AsCurrency      := LobjXML.Total.BaseIS_Doc;
        qryTabela.FieldByName('RT_PALIQ_IBSUF').AsCurrency  := LobjXML.Total.AliqEfetIBSUF_Doc;
        qryTabela.FieldByName('RT_PALIQ_IBSMUN').AsCurrency := LobjXML.Total.AliqEfetIBSMun_Doc;
        qryTabela.FieldByName('RT_PALIQ_CBS').AsCurrency    := LobjXML.Total.AliqEfetCBS_Doc;
        If Assigned(LobjXML.Product(0)) Then
        Begin
          qryTabela.FieldByName('RT_CST').AsString            := LobjXML.Product(0).CSTIBSCBS;
          qryTabela.FieldByName('RT_CCLASSTRIB').AsString     := LobjXML.Product(0).cClassTrib;
          qryTabela.FieldByName('RT_CSTREG').AsString         := LobjXML.Product(0).CSTReg;
          qryTabela.FieldByName('RT_AIUREG').AsCurrency       := LobjXML.Product(0).pAliqEfetRegIBSUF;
          qryTabela.FieldByName('RT_TIUREG').AsCurrency       := LobjXML.Product(0).vTribRegIBSUF;
          qryTabela.FieldByName('RT_AIMREG').AsCurrency       := LobjXML.Product(0).pAliqEfetRegIBSMun;
          qryTabela.FieldByName('RT_TIMREG').AsCurrency       := LobjXML.Product(0).vTribRegIBSMun;
          qryTabela.FieldByName('RT_CBSREG').AsCurrency       := LobjXML.Product(0).pAliqEfetRegCBS;
          qryTabela.FieldByName('RT_TCBREG').AsCurrency       := LobjXML.Product(0).vTribRegCBS;
        End;

        qryTabela.FieldByName('SCE_TPPCOM').AsString   := LobjXML.SCEE.TpPartComp;
        qryTabela.FieldByName('SCE_IDACGE').AsString   := LobjXML.SCEE.IdAcessGer;
        qryTabela.FieldByName('SCE_VPTINS').AsCurrency := LobjXML.SCEE.VPotInst;
        qryTabela.FieldByName('SCE_TPFENE').AsString   := LobjXML.SCEE.TpFonteEnergia;
        qryTabela.FieldByName('SCE_ENEALO').AsCurrency := LobjXML.SCEE.EnerAloc;
        qryTabela.FieldByName('SCE_TPPTAR').AsString   := LobjXML.SCEE.TpPosTar;
        qryTabela.FieldByName('SCE_ENEINJ').AsCurrency := LobjXML.SCEE.EnerInjet;
        qryTabela.FieldByName('SCE_TPPINJ').AsString   := LobjXML.SCEE.TpPosTarInjet;

        pCalculaPisCofins;
        qryTabela.Post;
        if Assigned(prgProgresso) then
          prgProgresso.Position := prgProgresso.Position + 1;
      end;

      { Carregar Abreivações de acordo com CFOPs}
      fCarregaAbrevPisCofPrg(prgProgresso);

      { Validação }
      qryTabela.FIrst;
      While Not qryTabela.Eof Do
      Begin
        If qryTabela.FieldByName('REGISTRO_VALIDO').AsString = 'N' Then
        Begin
          qryTabela.Next;   // XML inválido já marcado na carga
          Continue;
        End;
        qryTabela.Edit;
        If fValidarRegistroIndividual Then
         begin
          qryTabela.FieldByName('REGISTRO_VALIDO').AsString := 'S';
          qryTabela.FieldByName('IMPORTAR').AsString := 'S';
        end
        else
        begin
          qryTabela.FieldByName('REGISTRO_VALIDO').AsString := 'N';
          qryTabela.FieldByName('IMPORTAR').AsString := 'N';
        end;
        qryTabela.Next;
      End;
      qryTabela.FIrst;
    finally
      qryTabela.EnableControls;
    end;
    Result := not qryTabela.IsEmpty;
  finally
    LobjListaXML.Free;
  end;
end;

function TEntImpConsumo.fValidarRegistroIndividual: Boolean;
Var
  LstrErro: String;
begin
  LstrErro := '';

  if fEmptyStr(FstrCodigoPortador) and fCfgSis('CTPAVI', varBoolean) and FblnGerarContasAPagar then
    LstrErro := LstrErro + 'Documento: O portador deve ser informado! <<csq>>';
  if fEmptyStr(FstrCodigoConta) and FblnGerarContasAPagar then
    LstrErro := LstrErro + 'Documento: O código da conta deve ser informado! <<csq>>';
  if fEmptyStr(qryTabela.FieldByName('CODIGO_DESTINATARIO').AsString) then
    LstrErro := LstrErro + 'Documento: Empresa não localizada. <<csq>>';
  if qryTabela.FieldByName('CODIGO_DESTINATARIO').AsString <> Vs_strCodEmp then
    LstrErro := LstrErro + 'Documento: O destinatário deve ser a empresa logada. <<csq>>';
  if fEmptyStr(qryTabela.FieldByName('NUMERO_DOCUMENTO').AsString) then
    LstrErro := LstrErro + 'Documento: Número do documento não encontrado. <<csq>>';
  if fEmptyStr(qryTabela.FieldByName('DATA_EMISSAO').AsString) then
    LstrErro := LstrErro + 'Documento: Data de emissão não informada. <<csq>>';
  if fEmptyStr(qryTabela.FieldByName('CODIGO_EMITENTE').AsString) then
    LstrErro := LstrErro + 'Documento: Fornecedor não cadastrado. <<csq>>';
  if fEmptyStr(qryTabela.FieldByName('CNPJ_EMITENTE').AsString) then
    LstrErro := LstrErro + 'Documento: CNPJ do emitente inválido. <<csq>>';
  if qryTabela.FieldByName('VALOR_TOTAL').AsCurrency <= 0 then
    LstrErro := LstrErro + 'Documento: Valor total da nota está zerado. <<csq>>';
  if fEmptyStr(qryTabela.FieldByName('CST_PIS').AsString) then
    LstrErro := LstrErro + 'Nenhuma Abreviação cadastrada para a CFOP ' + qryTabela.FieldByName('CFOP').AsString + '. <<csq>>' +
                  'Cadastre as Abreviações em Principal/ Manutenção de Cadastros/ Auxiliares/ Abreviação PIS! <<csq>>';
  if fEmptyStr(qryTabela.FieldByName('CST_COFINS').AsString) then
    LstrErro := LstrErro + 'Nenhuma Abreviação cadastrada para a CFOP ' + qryTabela.FieldByName('CFOP').AsString + '. <<csq>>' +
                  'Cadastre as Abreviações em Principal/ Manutenção de Cadastros/ Auxiliares/ Abreviação COFINS! <<csq>>';

  if FblnGerarContasAPagar And (Not FblnImportarSemVencimento) And fEmptyStr(qryTabela.FieldByName('CONDICAO_PAGAMENTO').AsString) then
    LstrErro := LstrErro + 'Arquivo sem vencimentos.'+ '<<csq>>';

  If FblnGerarContasAPagar And (FblnUSACTF) And (Not fConsultarConta) Then
    LstrErro := LstrErro + 'Documento: Esse Plano de Contas: ' + FstrCodigoConta + ' não está cadastrado ou não está vinculado ao fornecedor: '+
      qryTabela.FieldByName('CODIGO_EMITENTE').AsString + '<<csq>>';

  If fValidaNumNota(qryTabela.FieldByName('NUMERO_DOCUMENTO').AsString,
                    qryTabela.FieldByName('ESPECIE_DOCUMENTO').AsString,
                    qryTabela.FieldByName('CODIGO_DESTINATARIO').AsString,
                    qryTabela.FieldByName('SERIE_DOCUMENTO').AsString,
                    qryTabela.FieldByName('CODIGO_EMITENTE').AsString) Then
  Begin
    LstrErro := LstrErro + 'O documento já existe.<<csq>>';
    fAlterarStatus(DOCUMENTO_JA_EXISTE,LstrErro);
  End
  Else if Not fEmptyStr(LstrErro) Then
    fAlterarStatus(IMPORTADO_COM_ERRO, LstrErro)
  Else
    fAlterarStatus;
  Result := fEmptyStr(LstrErro);
end;

Function TEntImpConsumo.fConsultarConta: Boolean;
Var
  LqryCons: TUniQuery;
Begin
  LqryCons := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  Try
    pPesquisaCadCta(LqryCons, LqryCons, FstrCodigoConta, True, qryTabela.FieldByName('CODIGO_EMITENTE').AsString);
    Result := Not fEmptyStr(LqryCons.FieldByName('CTA_CODCTA').AsString);
  Finally
    FreeAndNil(LqryCons);
  End;
End;

procedure TEntImpConsumo.pMarcarTodosRegistros(blnMarcar: Boolean);
begin
  qryTabela.DisableControls;
  try
    qryTabela.First;
    while not qryTabela.Eof do
    begin
      qryTabela.Edit;

      if blnMarcar then
      begin
        { Regra: Só permite marcar para importar se o registro for válido }
        if qryTabela.FieldByName('REGISTRO_VALIDO').AsString = 'S' then
          qryTabela.FieldByName('IMPORTAR').AsString := 'S'
        else
          qryTabela.FieldByName('IMPORTAR').AsString := 'N';
      end
      else
        qryTabela.FieldByName('IMPORTAR').AsString := 'N';

      qryTabela.Post;
      qryTabela.Next;
    end;
  finally
    qryTabela.EnableControls;
  end;
end;

function TEntImpConsumo.fConfirmarImportacaoConsumo(prgProgresso
  : TcxProgressBar): Boolean;
Var
  LstrNomeArquivo: String;
begin
  qryTabela.Filtered := False;
  qryTabela.Filter := 'STATUS = ''0'' AND IMPORTAR = ''S'' AND REGISTRO_VALIDO = ''S''';
  qryTabela.Filtered := True;
  qryTabela.DisableControls;

  if Assigned(prgProgresso) then
  begin
    prgProgresso.Properties.Max := qryTabela.RecordCount;
    prgProgresso.Position := 0;
  end;
  Try
    qryTabela.First;
    while not qryTabela.IsEmpty do
    begin
      fStartTransaction;
      Try
        pGravarCadFis;
        pCriaMovGerMovDet;
        pGravarXmlImportado;
        if FblnGerarContasAPagar then
          pGravarCadPag;

        if Assigned(prgProgresso) then
          prgProgresso.Position := prgProgresso.Position + 1;

        fCommit;

        LstrNomeArquivo := qryTabela.FieldByName('ARQUIVO').AsString;
        If FileExists(LstrNomeArquivo) Then
          RenameFile(LstrNomeArquivo, AnsiLeftStr(LstrNomeArquivo, Length(LstrNomeArquivo) - 3) + 'old');
        qryTabela.Delete;
      Except
        on E: Exception do
        begin
          fRollback;
          qryTabela.Edit;
          fAlterarStatus(COM_ERRO_GRAVACAO, e.message);
          qryTabela.Post;
        end;
      End;
      qryTabela.First;
    end;
  Finally
    qryTabela.EnableControls;
    qryTabela.Filtered := False;
    Result := qryTabela.IsEmpty;
  End;
end;

procedure TEntImpConsumo.pGravarCadPag;
var
  LdtaDtaPag: TDateTime;
  LstrPorBai: String;
  LintContador: Integer;
  LintCtpCon: LongInt;
  LstrHistorico: string;
  LstrHisBai: string;
  LstrCtaBai: string;
  LstrDocBai: string;
  LstrOpeBai: string;
  LstrSeqLan: string;
  LfltValPag: Double;
  LstrCodFor: String;
  LstrSerie: String;
  LdobValor: Double;
  LlstBanCtp: TBanCtpRepository;
  LstrNumeroDocumento: String;
  LstrAutPag: String;
  LstrLinDig: String;
  LstrCodBar: String;
  LstrCompetencia: String;
  LstrCondicao: String;
  LblnVeioBoleto: Boolean;
  LblnGerouContaPagar: Boolean;
begin
  LintContador := 0;
  LstrSerie := qryTabela.FieldByName('SERIE_DOCUMENTO').AsString;
  LstrCodFor := qryTabela.FieldByName('CODIGO_EMITENTE').AsString;
  LdobValor := qryTabela.FieldByName('VALOR_TOTAL').AsCurrency;
  LstrNumeroDocumento := qryTabela.FieldByName('NUMERO_DOCUMENTO').AsString;
  LstrLinDig := qryTabela.FieldByName('CODIGO_BARRAS').AsString;
  LstrCodBar := qryTabela.FieldByName('CODIGO_BARRAS').AsString;
  LstrCompetencia := qryTabela.FieldByName('COMPETENCIA').AsString;
  if FblnGerarContasAPagar then
    LstrCondicao := qryTabela.FieldByName('CONDICAO_PAGAMENTO').AsString;
  LblnVeioBoleto := qryTabela.FieldByName('CODIGO_BARRAS').AsString <> '';

  if  Not fCfgSis('ENTCTP', varBoolean) then
    Exit;

  If Not fMontaDuplicatasXML Then
    fDigDuplic(
      FarrDuplicata,
      LstrCondicao,
      0,
      LdobValor,
      False,
      True,
      False,
      qryTabela.FieldByName('DATA_EMISSAO').AsDateTime,
      True,
      0
    );


  LintCtpCon := fRetornaSequencialUnico('CTPCON', FstrCodigoEmpresa);

  while (LintContador < 24) and (FarrDuplicata[LintContador].dtaDtaVen <> '') do
  begin
    LstrHistorico := fGerarHistoricoCTP;
    LdtaDtaPag := 0;
    LstrPorBai := '';
    LstrHisBai := '';
    LstrCtaBai := '';
    LstrDocBai := '';
    LstrOpeBai := '';
    LfltValPag := 0;
    LstrSeqLan := '';

    if (fCfgSis('CTPAVI', varBoolean)) and
       (StrToDate(FarrDuplicata[LintContador].dtaDtaVen) = VS_Date) then
    begin
      LlstBanCtp := TBanCtpRepository.Create;
      try
        LlstBanCtp.fAdd(
          LstrNumeroDocumento,
          'A',
          LstrSerie,
          VS_strCodEmp,
          LstrCodFor,
          LstrHistorico,
          '',
          FstrCodigoConta,
          VS_strCodEmp,
          0,
          FarrDuplicata[LintContador].curValor,
          0,
          0,
          0,
          0
        );

        LstrSeqLan := fGravaMovBan(
          FstrCodigoConta,
          FstrCodigoPortador,
          FstrCodigoOperador,
          VS_Date,
          fTime(),
          LstrNumeroDocumento,
          'D',
          FstrCodigoEmpresa,
          FarrDuplicata[LintContador].curValor,
          LstrHistorico,
          '',
          '',
          LstrCodFor,
          LstrNumeroDocumento,
          0,
          'A',
          FstrCodigoEmpresa,
          LstrSerie,
          FstrCodigoEvento,
          '',
          LlstBanCtp.fGetList,
          0,
          LintCtpCon
        );

        LstrHisBai := LstrHistorico;
        LstrCtaBai := FstrCodigoConta;
        LstrDocBai := LstrSeqLan;
        LstrOpeBai := strLoginUsuarioLogado;
        LfltValPag := FarrDuplicata[LintContador].curValor;
        LstrPorBai := FstrCodigoPortador;
        LdtaDtaPag := fNow();
      finally
        FreeAndNil(LlstBanCtp);
      end;
    end;

    if not fVerificaTemCadPag(FarrDuplicata[LintContador].strSequen) then
    begin
      LstrAutPag := fRetAutoIncrem('CADPAG', VS_strCodEmp);

      FarrDuplicata[LintContador].strUsaChq := IfThen(Pos(FarrDuplicata[LintContador].strUsaChq, 'S_N_') <= 0, 'N',
                                               FarrDuplicata[LintContador].strUsaChq);

      LblnGerouContaPagar := fGravaCadPag(
        'TfrmEntImpConsumo',                               // 1. strNomFrmLogCtp
        'BAIXA - NOTA FISCAL DE CONSUMO',                  // 2. strDescriLogCtp
        LstrCodFor,                                        // 3. strCodFor
        LstrNumeroDocumento,                               // 4. strNumDup
        FarrDuplicata[LintContador].strSequen,              // 5. strParcel

        FstrCodigoEmpresa,                                 // 6. strCodEmp
        FstrCodigoConta,                                   // 7. strCodCta
        LstrSerie,                                         // 8. strSerie
        0,                                                 // 9. intSeqBai
        FdtaDataEntrada,                                   // 10. dtaDtaCad
        StrToDate(FarrDuplicata[LintContador].dtaDtaVen),  // 11. dtaDtaVen
        FarrDuplicata[LintContador].curValor - LfltValPag, // 12. fltValDup
        FarrDuplicata[LintContador].curValor,              // 13. fltValOri
        'N',                                               // 14. strPrevis
        Iif(LblnVeioBoleto, 'S', 'N'),                     // 15. strVeiobo
        'N',                                               // 16. strDeposi
        LstrHistorico,                                     // 17. strHist01
        '',                                                // 18. strHist02
        LstrHisBai,                                        // 19. strHisbai
        LstrPorBai,                                        // 20. strPorBai
        LstrCtaBai,                                        // 21. strCtaBai
        LstrSeqLan,                                        // 22. strDocBai
        LstrOpeBai,                                        // 23. strOpeBai
        LdtaDtaPag,                                        // 24. dtaDtaPag
        LfltValPag,                                        // 25. fltValPag
        0,                                                 // 26. fltValJur
        0,                                                 // 27. fltValDes
        FstrCodigoEmpresa,                                 // 28. strEmpGer
        FstrCodigoEvento,                                  // 29. strCodEve
        FarrDuplicata[LintContador].strUsaChq,             // 30. strUsaChq
        FstrCodigoPortador,                                // 31. strCodPor
        LstrNumeroDocumento,                               // 32. strNumDoc
        0.0,                                               // 33. fltJurSuj
        0.0,                                               // 34. fltDesSuj
        LintCtpCon,                                        // 35. intSeqCon
        False,                                             // 36. blnResCai
        0,                                                 // 37. intRcxCon
        '',                                                // 38. strTipDoc
        0,                                                 // 39. fltVendor
        '',                                                // 40. strVeioNF
        '',                                                // 41. strNotEnt
        '',                                                // 42. strNotTip
        '',                                                // 43. strCTPCom
        LstrAutPag,                                        // 44. strAutInc
        '',                                                // 45. strDocTer
        '',                                                // 46. strEspTer
        '',                                                // 47. strEmpTer
        '',                                                // 48. strCliTer
        'N',                                               // 49. strUsoCon
        LstrCompetencia,                                   // 50. strCompet
        '',                                                // 51. strCodCliUC
        '',                                                // 52. strNumDocUC
        '',                                                // 53. strEspDocUC
        '',                                                // 54. strCodEmpUC
        LfltValPag,                                        // 55. fltDinhei
        0,                                                 // 56. fltChqAvi
        0,                                                 // 57. fltOrdPag
        0,                                                 // 58. fltRepChq
        '',                                                // 59. strCodVen
        0,                                                 // 60. fltJurAnt
        0,                                                 // 61. fltDesAnt
        LstrLinDig,                                        // 62. strLinDig
        LstrCodBar,                                        // 63. strCodBar
        '',                                                // 64. strAutCtp
        '',                                                // 65. strNFNumDup
        '',                                                // 66. strAutIncBaixaEmprestimo
        '0',                                               // 67. strQ_Guia
        '',                                                // 68. strCodRec
        '',                                                // 69. strBcoFor
        '',                                                // 70. strAutIncLogCTP
        '',                                                // 71. strCodPrj
        'N',                                               // 72. strPagAntecipado
        '',                                                // 73. strAutIncFunrural
        '',                                                // 74. strGnreNumeroDocumento
        '',                                                // 75. strGnreChaveDeAcesso
        '',                                                // 76. strGnreNumeroDeControle
        0,                                                 // 77. dtaGnreDataPrevisaoPagamento
        '',                                                // 78. strGnreConvenio
        0,                                                 // 79. fltMulSuj
        '',                                                // 80. strAutIncPix
        0,                                                 // 81. fltGrvOri
        0,                                                 // 82. ADtaLiberacao
        0,                                                 // 83. AHorLiberacao
        '',                                                // 84. AOpeLiberacao
        '',                                                // 85. strGnreChaveDeApuracao
        FstrAutIncCadFis                                   // 86. AIncCadFis
      );
      If Not LblnGerouContaPagar Then
        raise Exception.Create('Erro ao gravar contas a pagar [TEntImpConsumo.pGravarCadPag]' );
    end;

    Inc(LintContador);
  end;
end;

function TEntImpConsumo.fGerarHistoricoCTP: String;
Begin
  Result := '';
  If (fCfgSis('HISCTP', varBoolean)) Then
  Begin
    Result := 'REF. LANCAMENTO DE NOTA FISCAL DE CONSUMO ' + qryTabela.FieldByName('NUMERO_DOCUMENTO').AsString + '- ' +
              qryTabela.FieldByName('ESPECIE_DOCUMENTO').AsString +
              ' DTA. EMISSÃO: ' + qryTabela.FieldByName('DATA_EMISSAO').AsString +
              ' CLIENTE/FORNECEDOR: ' + qryTabela.FieldByName('CODIGO_EMITENTE').AsString + ' - ' +
              ' DOCUMENTO: ' + qryTabela.FieldByName('NUMERO_DOCUMENTO').AsString  +  ' - ' +
              qryTabela.FieldByName('ESPECIE_DOCUMENTO').AsString +  ' - ' +
                FstrCodigoEmpresa;
  End;
End;

function TEntImpConsumo.fCFOPConsumo(const AstrCFOPXML: String): String;
var
  LstrCFOP        : String;
  LintTipoEmpresa : Integer;
  LintModelo      : Integer;
begin
  Result   := '';
  LstrCFOP := Trim(AstrCFOPXML);

  if not fEmptyStr(LstrCFOP) then
    Result := fCfopConvertidoParaEntrada(LstrCFOP);

  if fEmptyStr(Result) and (Length(LstrCFOP) = 4) and
     CharInSet(LstrCFOP[1], ['5', '6', '7']) then
  begin
    Result := LstrCFOP;
    case Result[1] of
      '5': Result[1] := '1';
      '6': Result[1] := '2';
      '7': Result[1] := '3';
    end;
  end;

  if (Length(Result) <> 4) or
     not CharInSet(Result[1], ['1', '2', '3']) then
  begin
    LintTipoEmpresa := fCampoTabela('EMP_ATIPRE', 'CADEMP',
      ['EMP_CODEMP'], [FstrCodigoEmpresa]);
    LintModelo := qryTabela.FieldByName('MODELO_DOCUMENTO').AsInteger;

    case LintModelo of
      66: // NF3e — Energia Elétrica
        case LintTipoEmpresa of
          0: Result := '1252'; // industrial
          2: Result := '1253'; // comércio
        else
          Result := '1253';
        end;
      62: // NFCom — Telecomunicações
        case LintTipoEmpresa of
          0: Result := '1302'; // industrial
          2: Result := '1303'; // comércio
        else
          Result := '1303';
        end;
      75: Result := '1556';
    else
      Result := '1949';
    end;
  end;
end;

procedure TEntImpConsumo.pGravarCadFis;
Var
  LblnGravou: Boolean;
  LstrNatOpe: String;
  LstrCFOP: String;
  LstrCodCCE: String;
  LstrCodGRT: String;
Begin
  LstrCFOP := qryTabela.FieldByName('CFOP').AsString;
  LstrNatOpe := fCampoTabela('NAT_DESCRI', 'NATCFO', ['NAT_CODCFO'], [LstrCFOP]);
  LstrCodCCE := fNormalizarCodEnergiaEletrica(qryTabela.FieldByName('CCODCONS').AsString, 1, 8);
  LstrCodGRT := fNormalizarCodEnergiaEletrica(qryTabela.FieldByName('CGRUPOTENSAO').AsString, 1, 14);

  LblnGravou := fGravaCadFis(
    FstrAutIncCadFis,                                      // strAutInc
    FdtaDataEntrada,                                       // dtaDtaEnt
    qryTabela.FieldByName('NUMERO_DOCUMENTO').AsString,    // strNumDoc
    '',                                                    // strNumDo2
    qryTabela.FieldByName('ESPECIE_DOCUMENTO').AsString,  // strEspDoc
    'E',                                                   // strEntSai
    qryTabela.FieldByName('DATA_EMISSAO').AsDateTime,      // dtaDtaDoc
    'F',                                                   // strTip_Fc
    qryTabela.FieldByName('CODIGO_EMITENTE').AsString,     // strForCli
    qryTabela.FieldByName('COMPLEMENTO').AsString,         // strHistor
    'N',                                                   // strNfComp
    '',                                                    // strNotEsp

    // --- Classificação Fiscal 1 ---
    qryTabela.FieldByName('CFOP').AsString,                // strClfSc1
    qryTabela.FieldByName('VALOR_TOTAL').AsCurrency,       // fltVlCon1
    0,                                                     // fltBasIc1
    0,                                                     // fltAlqIc1
    0,                                                     // fltVlrIc1
    qryTabela.FieldByName('VALOR_TOTAL').AsCurrency,       // fltOutra1
    0,                                                     // fltIsent1
    0,                                                     // fltRetid1
    0,                                                     // fltBasIp1
    0,                                                     // fltVlrIp1
    0,                                                     // fltBcRet1
    0,                                                     // fltDAces1
    0,                                                     // fltValIs1

    // --- Classificação Fiscal 2 ---
    '',                                                    // strClfSc2
    0,                                                     // fltVlCon2
    0,                                                     // fltBasIc2
    0,                                                     // fltAlqIc2
    0,                                                     // fltVlrIc2
    0,                                                     // fltOutra2
    0,                                                     // fltIsent2
    0,                                                     // fltRetid2
    0,                                                     // fltBasIp2
    0,                                                     // fltVlrIp2
    0,                                                     // fltBcRet2
    0,                                                     // fltDAces2
    0,                                                     // fltValIs2

    // --- Classificação Fiscal 3 ---
    '',                                                    // strClfSc3
    0,                                                     // fltVlCon3
    0,                                                     // fltBasIc3
    0,                                                     // fltAlqIc3
    0,                                                     // fltVlrIc3
    0,                                                     // fltOutra3
    0,                                                     // fltIsent3
    0,                                                     // fltRetid3
    0,                                                     // fltBasIp3
    0,                                                     // fltVlrIp3
    0,                                                     // fltBcRet3
    0,                                                     // fltDAces3
    0,                                                     // fltValIs3

    // --- Classificação Fiscal 4 ---
    '',                                                    // strClfSc4
    0,                                                     // fltVlCon4
    0,                                                     // fltBasIc4
    0,                                                     // fltAlqIc4
    0,                                                     // fltVlrIc4
    0,                                                     // fltOutra4
    0,                                                     // fltIsent4
    0,                                                     // fltRetid4
    0,                                                     // fltBasIp4
    0,                                                     // fltVlrIp4
    0,                                                     // fltBcRet4
    0,                                                     // fltDAces4
    0,                                                     // fltValIs4

    // --- Classificação Fiscal 5 ---
    '',                                                    // strClfSc5
    0,                                                     // fltVlCon5
    0,                                                     // fltBasIc5
    0,                                                     // fltAlqIc5
    0,                                                     // fltVlrIc5
    0,                                                     // fltOutra5
    0,                                                     // fltIsent5
    0,                                                     // fltRetid5
    0,                                                     // fltBasIp5
    0,                                                     // fltVlrIp5
    0,                                                     // fltBcRet5
    0,                                                     // fltDAces5
    0,                                                     // fltValIs5

    // --- Totais PIS/COFINS ---
    qryTabela.FieldByName('VALOR_PIS').AsCurrency,         // fltTotPis
    qryTabela.FieldByName('VALOR_COFINS').AsCurrency,      // fltTotCof
    qryTabela.FieldByName('BASE_PIS').AsCurrency,          // fltBasPis
    qryTabela.FieldByName('BASE_COFINS').AsCurrency,       // fltBasCof
    qryTabela.FieldByName('ALIQUOTA_PIS').AsCurrency,      // fltAlqPis
    qryTabela.FieldByName('ALIQUOTA_COFINS').AsCurrency,   // fltAlqCof

    // --- Identificação Adicional ---
    VS_strCodEmp,                                          // strCodEmp
    qryTabela.FieldByName('SERIE_DOCUMENTO').AsString,     // strSerie
    qryTabela.FieldByName('ESTADO_EMITENTE').AsString,     // strEstado
    '',                                                    // strNumSer
    '',                                                    // strNumCoo
    '',                                                    // strCodCon
    '',                                                    // strDocCon
    qryTabela.FieldByName('CHAVE_ACESSO').AsString,        // strChaveAcesso
    '',                                                    // strNumeroProtocolo
    'C',                                                   // strOriDoc
    '',                                                    // strEmpAut

    // --- Impostos e Importação ---
    0,                                                     // fltImpMer
    0,                                                     // fltImpSeg
    0,                                                     // fltImpImp
    0,                                                     // fltImpPro
    0,                                                     // fltImpTax
    0,                                                     // fltImpPis
    0,                                                     // fltImpCof
    '',                                                    // strImpIC1
    '',                                                    // strImpIC2
    '',                                                    // strModFre
    0,                                                     // fltBasIss
    0,                                                     // fltAlqIss
    0,                                                     // fltValIss
    0,                                                     // fltBaseII
    0,                                                     // fltDesAdu
    0,                                                     // fltValIOF

    // --- Antecipação ICMS ---
    0,                                                     // fltBasAn1
    0,                                                     // fltAntIc1
    0,                                                     // fltBasAn2
    0,                                                     // fltAntIc2
    0,                                                     // fltBasAn3
    0,                                                     // fltAntIc3
    0,                                                     // fltBasAn4
    0,                                                     // fltAntIc4
    0,                                                     // fltBasAn5
    0,                                                     // fltAntIc5

    // --- CST Entrada e Opções ---
    '',                                                    // strCstEnt
    FblnGerarContasAPagar,                                 // blnGraCTP

    // --- Bases e Valores Retidos ---
    0,                                                     // fltBaeRe1
    0,                                                     // fltVaeRe1
    0,                                                     // fltBaeRe2
    0,                                                     // fltVaeRe2
    0,                                                     // fltBaeRe3
    0,                                                     // fltVaeRe3
    0,                                                     // fltBaeRe4
    0,                                                     // fltVaeRe4
    0,                                                     // fltBaeRe5
    0,                                                     // fltVaeRe5

    // --- Bases e Valores IPI ---
    0,                                                     // fltBaeIP1
    0,                                                     // fltVaeIP1
    0,                                                     // fltBaeIP2
    0,                                                     // fltVaeIP2
    0,                                                     // fltBaeIP3
    0,                                                     // fltVaeIP3
    0,                                                     // fltBaeIP4
    0,                                                     // fltVaeIP4
    0,                                                     // fltBaeIP5
    0,                                                     // fltVaeIP5

    // --- CSTs e Outros ---
    qryTabela.FieldByName('CST_PIS').AsString,             // strCtsPis
    qryTabela.FieldByName('CST_COFINS').AsString,          // strCtsCof
    qryTabela.FieldByName('MODELO_DOCUMENTO').AsString,    // strCodMod
    '',                                                    // strVENCOM

    // --- FCP ST ---
    0,                                                     // fltBFCPS1
    0,                                                     // fltVFCPS1
    0,                                                     // fltBFCPS2
    0,                                                     // fltVFCPS2
    0,                                                     // fltBFCPS3
    0,                                                     // fltVFCPS3
    0,                                                     // fltBFCPS4
    0,                                                     // fltVFCPS4
    0,                                                     // fltBFCPS5
    0,                                                     // fltVFCPS5
    0,                                                     // fltALQFCP
    0,                                                     // fltTotRmm
    '',                                                    // strCodTra

    // --- Retenções ---
    qryTabela.FieldByName('VALOR_REIRRF').AsCurrency,      // fltIrSeRt
    qryTabela.FieldByName('VALOR_RETPIS').AsCurrency,      // fltPiSeRt
    qryTabela.FieldByName('VALOR_RETCOFINS').AsCurrency,   // fltCoSeRt
    qryTabela.FieldByName('VALOR_RETCSLL').AsCurrency,     // fltCsSeRt
    0,                                                     // fltRetISS
    0,                                                     // fltRetINS

    // --- FCP Normal ---
    0,                                                     // fltBAFCP1
    0,                                                     // fltVLFCP1
    0,                                                     // fltBAFCP2
    0,                                                     // fltVLFCP2
    0,                                                     // fltBAFCP3
    0,                                                     // fltVLFCP3
    0,                                                     // fltBAFCP4
    0,                                                     // fltVLFCP4
    0,                                                     // fltBAFCP5
    0,                                                     // fltVLFCP5

    // --- Finalizações ---
    '',                                                    // strTipFre
    0,                                                     // fltRFRBAS
    0,                                                     // fltRFRALQ
    0,                                                     // fltRFRVAL
    '',                                                    // strCstIPI
    'N',                                                   // strNfCIAP
    0,                                                     // fltPesCTE
    '',                                                    // strEstornoNotaFiscal
    '',                                                    // strEstornoNotaFiscalMotivo
    LstrNatOpe,                                            // strNatOpe
    '', // strTB01RE
    '', // strTB06RE
    '', // strBasFre
    False, // blnDevSim
    '', // strCdsErv
    0, // fltQBCMO1
    0, // fltQBCMO2
    0, // fltQBCMO3
    0, // fltQBCMO4
    0, // fltQBCMO5
    0, // fltQBCMO6
    0, // fltQBCMO7
    0, // fltQBCMO8
    0, // fltADREM1
    0, // fltADREM2
    0, // fltADREM3
    0, // fltADREM4
    0, // fltADREM5
    0, // fltADREM6
    0, // fltADREM7
    0, // fltADREM8
    0, // fltVALMO1
    0, // fltVALMO2
    0, // fltVALMO3
    0, // fltVALMO4
    0, // fltVALMO5
    0, // fltVALMO6
    0, // fltVALMO7
    0, // fltVALMO8
    '', // strNfsSub
    '', // strMesAno
    '', // strFinNfe
    '', // strFinTip
    qryTabela.FieldByName('TOT_IBS').AsCurrency,    // Req 425031 fltTotIbs
    qryTabela.FieldByName('TOT_CBS').AsCurrency,    // Req 425031 fltTotCbs
    qryTabela.FieldByName('TOT_IS').AsCurrency,     // Req 425031 fltTotIs
    qryTabela.FieldByName('TOT_PROIS').AsCurrency,  // Req 425031 fltTotProIs
    qryTabela.FieldByName('TOT_NF_RT').AsCurrency,  // Req 425031 fltTotNf
    '', // strNumDPS
    '', // strSerDPS
    LstrCodCCE,                                            // strCodCCE - CADFIS.FIS_CODCCE
    LstrCodGRT                                             // strCodGRT - CADFIS.FIS_CODGRT
  );
  If Not LblnGravou Then
    raise Exception.Create('Erro ao gravar CadFis [TEntImpConsumo.pGravarCadFis]');

  If (qryTabela.FieldByName('TOT_IBS').AsCurrency    <> 0) Or
     (qryTabela.FieldByName('TOT_CBS').AsCurrency    <> 0) Or
     (qryTabela.FieldByName('TOT_IS').AsCurrency     <> 0) Or
     (qryTabela.FieldByName('BC_IBSCBS').AsCurrency  <> 0) Then
  Begin
    fGravaFisRef(
      FstrAutIncCadFis,                                    // strSeqFis
      VS_strCodEmp,                                        // strCodEmp
      qryTabela.FieldByName('RT_CCLASSTRIB').AsString,     // strClatri
      qryTabela.FieldByName('VALOR_TOTAL').AsCurrency,     // fltVlrCon
      qryTabela.FieldByName('BC_IS').AsCurrency,          // fltBasIs
      // CBS
      qryTabela.FieldByName('RT_PALIQ_CBS').AsCurrency,    // fltCbsAlq
      0,                                                   // fltCbsDif
      0,                                                   // fltCbsRed
      qryTabela.FieldByName('TOT_CBS').AsCurrency,         // fltCbsVal <- SOMATORIO (v2)
      0,
      0,                                                // fltCbsVld, fltCbsVlr
      qryTabela.FieldByName('BC_IBSCBS').AsCurrency,       // fltCbsBas
      0,
      0,                                                // fltCbsBad, fltCbsBar
      // IBS UF
      qryTabela.FieldByName('BC_IBSCBS').AsCurrency,       // fltIbsUfb
      0,
      0,                                                // fltIbsUdb, fltIbsUrb
      qryTabela.FieldByName('RT_PALIQ_IBSUF').AsCurrency,  // fltIbsUfa
      0,
      0,                                                // fltIbsUfd, fltIbsUfr
      qryTabela.FieldByName('TOT_IBSUF').AsCurrency,       // fltIbsUfv <- SOMATORIO (v2)
      0,
      0,                                                // fltIbsUdv, fltIbsUrv
      // IBS Mun
      qryTabela.FieldByName('BC_IBSCBS').AsCurrency,       // fltIbsMnb
      0,
      0,                                                // fltIbsMdb, fltIbsMrb
      qryTabela.FieldByName('RT_PALIQ_IBSMUN').AsCurrency, // fltIbsMna
      0,
      0,                                                // fltIbsMnd, fltIbsMnr
      qryTabela.FieldByName('TOT_IBSMUN').AsCurrency,      // fltIbsMnv <- SOMATORIO (v2)
      0,
      0                                                 // fltIbsMdv, fltIbsMrv
    );
  End;
End;

procedure TEntImpConsumo.pCriaMovGerMovDet;
Var
  LObjConsumoItem: TXMLConsumoItem;
begin
  LObjConsumoItem := TXMLConsumoItem.Create;
  Try
    LObjConsumoItem
      .NumDoc(qryTabela.FieldByName('NUMERO_DOCUMENTO').AsString)
      .EspDoc(qryTabela.FieldByName('ESPECIE_DOCUMENTO').AsString) // Ou 'NFE' fixo
      .CodEmp(qryTabela.FieldByName('CODIGO_DESTINATARIO').AsString)
      .CodFor(qryTabela.FieldByName('CODIGO_EMITENTE').AsString)
      .Serie(qryTabela.FieldByName('SERIE_DOCUMENTO').AsString)
      .ClaFi1(qryTabela.FieldByName('CFOP').AsString)
      .vBC(qryTabela.FieldByName('BC_IBSCBS').AsCurrency)
      .TotNF(qryTabela.FieldByName('VALOR_TOTAL').AsFloat)
      // Req 425031 - RT no MOVREF (base + IS/IBS/CBS - usa SOMATORIOS - v2)
      .CST         (qryTabela.FieldByName('RT_CST').AsString)
      .ClassTrib   (qryTabela.FieldByName('RT_CCLASSTRIB').AsString)
      .pAliqEfetCBS(qryTabela.FieldByName('RT_PALIQ_CBS').AsFloat)
      .fpCBS        (qryTabela.FieldByName('RT_PALIQ_CBS').AsFloat)
      .vCBS        (qryTabela.FieldByName('TOT_CBS').AsFloat)         // v2 somatorio
      .pAliqEfetUF (qryTabela.FieldByName('RT_PALIQ_IBSUF').AsFloat)
      .pIBSUF      (qryTabela.FieldByName('RT_PALIQ_IBSUF').AsFloat)
      .vIBSUF      (qryTabela.FieldByName('TOT_IBSUF').AsFloat)       // v2 somatorio
      .pAliqEfetMun(qryTabela.FieldByName('RT_PALIQ_IBSMUN').AsFloat)
      .pIBSMun     (qryTabela.FieldByName('RT_PALIQ_IBSMUN').AsFloat)
      .IBSMun      (qryTabela.FieldByName('TOT_IBSMUN').AsFloat)      // v2 somatorio
      .IBSTot      (qryTabela.FieldByName('TOT_IBS').AsFloat)
      // Regime Regular
      .CSTReg            (qryTabela.FieldByName('RT_CSTREG').AsString)
      .pAliqEfetRegIBSUF (qryTabela.FieldByName('RT_AIUREG').AsFloat)
      .vTribRegIBSUF     (qryTabela.FieldByName('RT_TIUREG').AsFloat)
      .pAliqEfetRegIBSMun(qryTabela.FieldByName('RT_AIMREG').AsFloat)
      .vTribRegIBSMun    (qryTabela.FieldByName('RT_TIMREG').AsFloat)
      .pAliqEfetRegCBS   (qryTabela.FieldByName('RT_CBSREG').AsFloat)
      .vTribRegCBS       (qryTabela.FieldByName('RT_TCBREG').AsFloat)
      .TpPartComp     (qryTabela.FieldByName('SCE_TPPCOM').AsString)
      .IdAcessGer     (qryTabela.FieldByName('SCE_IDACGE').AsString)
      .VPotInst       (qryTabela.FieldByName('SCE_VPTINS').AsFloat)
      .TpFonteEnergia (qryTabela.FieldByName('SCE_TPFENE').AsString)
      .EnerAloc       (qryTabela.FieldByName('SCE_ENEALO').AsFloat)
      .TpPosTar       (qryTabela.FieldByName('SCE_TPPTAR').AsString)
      .EnerInjet      (qryTabela.FieldByName('SCE_ENEINJ').AsFloat)
      .TpPosTarInjet  (qryTabela.FieldByName('SCE_TPPINJ').AsString)
      .fCriarMovger;
  Finally
    LObjConsumoItem.Free;
  End;
end;

function TEntImpConsumo.fMontaDuplicatasXML: Boolean;
Begin
  Result := False;
  FillChar(FarrDuplicata, Sizeof(FarrDuplicata), #0);
  FillChar(FarrLinDigCodbar, Sizeof(FarrLinDigCodbar), #0);

  If Not fEmptyStr(qryTabela.FieldByName('FATURA').AsString) Then
  Begin
    FarrDuplicata[0].dtaDtaVen := qryTabela.FieldByName('DATA_VENCIMENTO').AsString;
    FarrDuplicata[0].curValor  := qryTabela.FieldByName('VALOR_TOTAL').AsCurrency;
    FarrDuplicata[0].strSequen := String(arrLetras[0]);
    FarrLinDigCodbar[0].strLinDig := qryTabela.FieldByName('CODIGO_BARRAS').AsString;
    FarrLinDigCodbar[0].strCodBar := qryTabela.FieldByName('CODIGO_BARRAS').AsString;
    Result := true;
  End;
end;

function TEntImpConsumo.fVerificaTemCadPag(AstrParcela: String): Boolean;
var
  qryCadPag: TUniQuery;
begin
  qryCadPag := fCriaQuery;
  try
    qryCadPag.SQL.Add('SELECT * FROM CADPAG');
    qryCadPag.SQL.Add('WHERE CTP_NUMDUP = :NUMDUP AND ');
    qryCadPag.SQL.Add('    CTP_PARCEL = :PARCEL AND ');
    qryCadPag.SQL.Add('    CTP_CODFOR = :CODFOR AND ');
    qryCadPag.SQL.Add('    CTP_CODEMP = :CODEMP');
    qryCadPag.ParamByName('NUMDUP').AsString := qryTabela.FieldByName('NUMERO_DOCUMENTO').AsString;
    qryCadPag.ParamByName('CODFOR').AsString := qryTabela.FieldByName('CODIGO_EMITENTE').AsString;
    qryCadPag.ParamByName('CODEMP').AsString := FstrCodigoEmpresa;
    qryCadPag.ParamByName('PARCEL').AsString := AstrParcela;
    qryCadPag.Open;
    Result := Not qryCadPag.IsEmpty;
  finally
    FreeAndNil(qryCadPag);
  end;
end;

Procedure TEntImpConsumo.pCalculaPisCofins;
Begin
  If (FblnSimPau Or fSimples) Then
  Begin
    qryTabela.FieldByName('VALOR_PIS').AsCurrency := 0;
    qryTabela.FieldByName('VALOR_COFINS').AsCurrency := 0;
    qryTabela.FieldByName('BASE_PIS').AsCurrency := 0;
    qryTabela.FieldByName('BASE_COFINS').AsCurrency := 0;
    qryTabela.FieldByName('ALIQUOTA_PIS').AsCurrency := 0;
    qryTabela.FieldByName('ALIQUOTA_COFINS').AsCurrency := 0;
  End;
End;

function TEntImpConsumo.fSimples: Boolean;
Var
  LqryAux: TUniQuery;
begin
  LqryAux := fCriaQuery;
  Try
    LqryAux.Close;
    LqryAux.SQL.Text := 'SELECT FOR_SIMPAU FROM CADFOR WHERE FOR_CODFOR = :CODFOR';
    LqryAux.ParamByName('CODFOR').AsString := qryTabela.FieldByName('CODIGO_EMITENTE').AsString;
    LqryAux.Open;
    Result := LqryAux.FieldByName('FOR_SIMPAU').AsString = 'S';
  Finally
    FreeAndNil(LqryAux);
  End;
end;

function TEntImpConsumo.fSelecionaAbreviacaoPisCOFINS(AstrTipo: String; AcdsPISCOFINS: TZClient;
  out AcurAliquota: Currency; out AstrCST: String; out AcurBase: Currency; out AblnTodos: Boolean): Boolean;
var
  LstrCFOP: String;
begin
  Result := False;
  LstrCFOP := qryTabela.FieldByName('CFOP').AsString;
  try
    pCriarFormularios(TfrmEscolhePisCofinsFrete, frmEscolhePisCofinsFrete);
    try
      frmEscolhePisCofinsFrete.Caption := 'Selecione a abreviação de ' + AstrTipo;
      frmEscolhePisCofinsFrete.chkCopTodas.Caption := 'Copiar para todas as notas com CFOP ' + LstrCFOP;
      frmEscolhePisCofinsFrete.cxgConsulta.DataController.DataSource := AcdsPISCOFINS.dtsSource;

      if frmEscolhePisCofinsFrete.ShowModal = mrOk then
      begin
        AcurAliquota := AcdsPISCOFINS.FieldByName('APC_ALQENT').AsCurrency;
        AstrCST      := AcdsPISCOFINS.FieldByName('APC_CSTENT').AsString;
        AcurBase     := AcdsPISCOFINS.FieldByName('APC_BASENT').AsCurrency;
        AblnTodos    := frmEscolhePisCofinsFrete.chkCopTodas.Checked;

        Result := True;
      end;
    finally
      if Assigned(frmEscolhePisCofinsFrete) then
        pFreeAndNil(frmEscolhePisCofinsFrete);
    end;

  except
    on E: Exception do
    begin
      Result := False;
      pMensagensErro(E.Message, '[TEntImpConsumo.fSelecionaAbreviacaoPisCOFINS]');
    end;
  end;
end;

procedure TEntImpConsumo.pAtualizarAbreviacaoCOFINS(AcurAliquota: Double; AcurBase: Double; AstrCST: String);
Begin
  qryTabela.Edit;
  qryTabela.FieldByName('ALIQUOTA_COFINS').AsFloat  := AcurAliquota;
  qryTabela.FieldByName('ALIQUOTA_BASE_COFINS').AsFloat  := AcurBase;
  qryTabela.FieldByName('CST_COFINS').AsString := AstrCST;
  qryTabela.Post;
End;

procedure TEntImpConsumo.pAtualizarAbreviacaoPIS(AcurAliquota: Double; AcurBase: Double; AstrCST: String);
Begin
  qryTabela.Edit;
  qryTabela.FieldByName('ALIQUOTA_PIS').AsFloat  := AcurAliquota;
  qryTabela.FieldByName('ALIQUOTA_BASE_PIS').AsFloat  := AcurBase;
  qryTabela.FieldByName('CST_PIS').AsString := AstrCST;
  qryTabela.Post;
End;

function TEntImpConsumo.fCarregaAbrevPisCofPrg(prgProgresso: TcxProgressBar): Boolean;
Var
  LintContador: Integer;
  LstrCFOP: String;
begin
  if Assigned(prgProgresso) then
  begin
    prgProgresso.Properties.Max := FstlListaCFOP.Count;
    prgProgresso.Position := 0;
  end;

  For LintContador := 0 to FstlListaCFOP.Count - 1 Do
  Begin
    LstrCFOP := FstlListaCFOP.Strings[LintContador];

    pProcessarTributacaoPIS(LstrCFOP);

    pProcessarTributacaoCOFINS(LstrCFOP);

    if Assigned(prgProgresso) then
      prgProgresso.Position := prgProgresso.Position + 1;
  End;

  Result := True;
End;

procedure TEntImpConsumo.pProcessarTributacaoPIS(const pCFOP: String);
var
  LcurAliquota: Currency;
  LcurBase: Currency;
  LstrCST: String;
  LblnTodos: Boolean;
  LblnSelecionado: Boolean;
begin
  LblnSelecionado := False;
  LcurAliquota    := 0;
  LcurBase        := 0;
  LstrCST         := '';
  LblnTodos       := True;

  pConsultarAbreviacaoPIS;
  FcdsAbrPis.Filtered := False;
  FcdsAbrPis.Filter   := 'CLAFIS = ' + QuotedStr(pCFOP);
  FcdsAbrPis.Filtered := True;

  if FcdsAbrPis.RecordCount = 1 then
  begin
    LcurAliquota    := FcdsAbrPis.FieldByName('APC_ALQENT').AsCurrency;
    LstrCST         := FcdsAbrPis.FieldByName('APC_CSTENT').AsString;
    LcurBase        := FcdsAbrPis.FieldByName('APC_BASENT').AsCurrency;
    LblnSelecionado := True;
  end
  else if FcdsAbrPis.RecordCount > 1 then
  begin
    LblnSelecionado := fSelecionaAbreviacaoPisCOFINS('PIS', FcdsAbrPis, LcurAliquota, LstrCST, LcurBase, LblnTodos);
  end;

  if not LblnSelecionado then
    Exit;

  qryTabela.DisableControls;
  try
    if LblnTodos then
    begin
      qryTabela.First;
      while not qryTabela.Eof do
      begin
        if qryTabela.FieldByName('CFOP').AsString = pCFOP then
        begin
          pAtualizarAbreviacaoPIS(LcurAliquota, LcurBase, LstrCST);

          if fEmptyStr(LstrCST) then
          begin
            qryTabela.Edit;
            fAlterarStatus(IMPORTADO_COM_ERRO, 'Abreviação PIS não informada!');
            qryTabela.Post;
          end;
        end;
        qryTabela.Next;
      end;
    end
    else
    begin
      pAtualizarAbreviacaoPIS(LcurAliquota, LcurBase, LstrCST);

      if fEmptyStr(LstrCST) then
      begin
        qryTabela.Edit;
        fAlterarStatus(IMPORTADO_COM_ERRO, 'Abreviação PIS não informada!');
        qryTabela.Post;
      end;
    end;
  finally
    qryTabela.EnableControls;
  end;
end;

procedure TEntImpConsumo.pProcessarTributacaoCOFINS(const pCFOP: String);
var
  LcurAliquota: Currency;
  LcurBase: Currency;
  LstrCST: String;
  LblnTodos: Boolean;
  LblnSelecionado: Boolean;
begin
  LblnSelecionado := False;
  LcurAliquota    := 0;
  LcurBase        := 0;
  LstrCST         := '';
  LblnTodos       := True;

  pConsultarAbreviacaoCOFINS;
  FcdsAbrCof.Filtered := False;
  FcdsAbrCof.Filter   := 'CLAFIS = ' + QuotedStr(pCFOP);
  FcdsAbrCof.Filtered := True;

  if FcdsAbrCof.RecordCount = 1 then
  begin
    LcurAliquota    := FcdsAbrCof.FieldByName('APC_ALQENT').AsCurrency;
    LstrCST         := FcdsAbrCof.FieldByName('APC_CSTENT').AsString;
    LcurBase        := FcdsAbrCof.FieldByName('APC_BASENT').AsCurrency;
    LblnSelecionado := True;
  end
  else if FcdsAbrCof.RecordCount > 1 then
  begin
    LblnSelecionado := fSelecionaAbreviacaoPisCOFINS('COFINS', FcdsAbrCof, LcurAliquota, LstrCST, LcurBase, LblnTodos);
  end;

  if not LblnSelecionado then
    Exit;

  qryTabela.DisableControls;
  try
    if LblnTodos then
    begin
      qryTabela.First;
      while not qryTabela.Eof do
      begin
        if qryTabela.FieldByName('CFOP').AsString = pCFOP then
        begin
          pAtualizarAbreviacaoCOFINS(LcurAliquota, LcurBase, LstrCST);

          if fEmptyStr(LstrCST) then
          begin
            qryTabela.Edit;
            fAlterarStatus(IMPORTADO_COM_ERRO, 'Abreviação COFINS não informada!');
            qryTabela.Post;
          end;
        end;
        qryTabela.Next;
      end;
    end
    else
    begin
      pAtualizarAbreviacaoCOFINS(LcurAliquota, LcurBase, LstrCST);

      if fEmptyStr(LstrCST) then
      begin
        qryTabela.Edit;
        fAlterarStatus(IMPORTADO_COM_ERRO, 'Abreviação COFINS não informada!');
        qryTabela.Post;
      end;
    end;
  finally
    qryTabela.EnableControls;
  end;
end;


procedure TEntImpConsumo.pConsultarAbreviacaoCOFINS;
var
  LintContador: Integer;
  LstrCFOP: String;
  LstrSQL: String;
begin
  LstrSQL := '';
  For LintContador := 0 to FstlListaCFOP.Count - 1 Do
  Begin
    LstrCFOP := FstlListaCFOP.Strings[LintContador];
    if LstrSQL <> '' then
      LstrSQL := LstrSQL + ' UNION ';
    LstrSQL := LstrSQL +
      'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, ' +
      'APC_CSTENT, APC_BASENT, APC_ALQENT, "' + LstrCFOP + '" AS CLAFIS ' +
      'FROM COFENT ' +
      'WHERE LOCATE("' + LstrCFOP + '", APC_CFOENT) > 0';
  End;

  If Not fEmptyStr(LstrSQL) Then
  Begin
    FcdsAbrCof.qryQuery.SQL.Text := LstrSQL;
    FcdsAbrCof.fAbreClient(True, 'TEntImpConsumo.pConsultarAbreviacaoCOFINS');
    FcdsAbrCof.IndexFieldNames := 'CLAFIS';
  End;
end;

function TEntImpConsumo.fDefineCndPag(const AstrCodFor: String): String;
var
  LqryConsulta: TUniQuery;
  LstrCndPag: String;
  LstrCodCnd: String;
begin
  Result := '';
  LqryConsulta := fCriaQuery;
  try
    LqryConsulta.SQL.Text := 'SELECT FOR_CODCND, FOR_CNDPAG FROM CADFOR '  +
      'WHERE FOR_CODFOR = :CODFOR';
    LqryConsulta.ParamByName('CODFOR').AsString := AstrCodFor;
    LqryConsulta.Open;

    If Not LqryConsulta.FieldByName('FOR_CNDPAG').IsNull Then
    Begin
      LstrCndPag := LqryConsulta.FieldByName('FOR_CNDPAG').AsString;
      LstrCodCnd := LqryConsulta.FieldByName('FOR_CODCND').AsString;

      if LstrCodCnd <> '' then
      begin
        LqryConsulta.Close;
        LqryConsulta.SQL.Text := 'SELECT CND_CODIGO, CND_TIPFOR, CND_CNDPAG ' +
          'FROM CADCND WHERE CND_CODIGO = :CNDPAG';
        LqryConsulta.ParamByName('CNDPAG').AsString := LstrCodCnd;
        LqryConsulta.Open;

        if not LqryConsulta.IsEmpty then
        begin
          LstrCndPag := untFuncoes.fRetCondicao(
            LstrCndPag,
            qryTabela.FieldByName('DATA_EMISSAO').AsDateTime,
            LqryConsulta.FieldByName('CND_CODIGO').AsString,
            LqryConsulta.FieldByName('CND_TIPFOR').AsString,
            LqryConsulta.FieldByName('CND_CNDPAG').AsString,
            qryTabela.FieldByName('DATA_EMISSAO').AsDateTime,
            '',
            '',
            True
          );
        end;
      end;

      Result := LstrCndPag;
    End;
  finally
    LqryConsulta.Free;
  end;
end;

function TEntImpConsumo.fRetornarCondicaoPagamentoXMl: String;
Begin
  Result := '';
  If fMontaDuplicatasXML Then
    Result := untFuncoesSimples.fRetornaCndPag(FarrDuplicata, qryTabela.FieldByName('DATA_EMISSAO').AsDateTime);
End;

function TEntImpConsumo.fImportarSemVencimento(AValor: Boolean): TEntImpConsumo;
begin
  Result := Self;
  FblnImportarSemVencimento := AValor;
end;

procedure TEntImpConsumo.pConsultarAbreviacaoPIS;
var
  LintContador: Integer;
  LstrCFOP: String;
  LstrSQL: String;
begin
  LstrSQL := '';
  for LintContador := 0 to FstlListaCFOP.Count - 1 do
  begin
    LstrCFOP := FstlListaCFOP.Strings[LintContador];
    if LstrSQL <> '' then
      LstrSQL := LstrSQL + ' UNION ';
    LstrSQL := LstrSQL +
      'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, ' +
      'APC_CSTENT, APC_BASENT, APC_ALQENT, "' + LstrCFOP + '" AS CLAFIS ' +
      'FROM PISENT ' +
      'WHERE LOCATE("' + LstrCFOP + '", APC_CFOENT) > 0';
  end;

  If Not fEmptyStr(LstrSQL) Then
  Begin
    FcdsAbrPis.qryQuery.SQL.Text := LstrSQL;
    FcdsAbrPis.fAbreClient(True, 'TEntImpConsumo.pConsultarAbreviacaoPIS');
    FcdsAbrPis.IndexFieldNames := 'CLAFIS';
  End;
end;



function TEntImpConsumo.fNormalizarCodEnergiaEletrica(const AstrValor: String;
                                                      AintMinimo, AintMaximo: Integer): String;
Var
  LintCodigo: Integer;
Begin
  Result := '';
  If fEmptyStr(AstrValor) Then
    Exit;
  If Not TryStrToInt(Trim(AstrValor), LintCodigo) Then
    Exit;
  If (LintCodigo < AintMinimo) Or (LintCodigo > AintMaximo) Then
    Exit;
  Result := fStrZero(IntToStr(LintCodigo), 2); // formato '01'..'14'
End;

procedure TEntImpConsumo.pGravarXmlImportado;
var
  LqryXmlImp : TUniQuery;
  LStream    : TStringStream;
  LstrArquivo: String;
begin
  If fEmptyStr(FstrAutIncCadFis) Then
    Exit;

  LstrArquivo := qryTabela.FieldByName('ARQUIVO').AsString;
  If fEmptyStr(LstrArquivo) Or (Not FileExists(LstrArquivo)) Then
    raise Exception.Create('Arquivo XML não encontrado: ' + LstrArquivo +
      ' [TEntImpConsumo.pGravarXmlImportado]');

  LStream    := nil;
  LqryXmlImp := fCriaQuery;
  Try
    LStream := TStringStream.Create(
      qryTabela.FieldByName('ARQUIVO_TEXTO').AsString, TEncoding.UTF8);

    LqryXmlImp.SQL.Text := 'SELECT * FROM XMLFIS WHERE FALSE';
    LqryXmlImp.Open;
    LqryXmlImp.Append;
    LqryXmlImp.FieldByName('IMP_SEQGER').AsString := FstrAutIncCadFis;
    TBlobField(LqryXmlImp.FieldByName('IMP_ARQXML')).LoadFromFile(LstrArquivo);
    TBlobField(LqryXmlImp.FieldByName('IMP_RECORD')).LoadFromStream(LStream);
    LqryXmlImp.Post;
    LqryXmlImp.Close;
  Finally
    FreeAndNil(LStream);
    FreeAndNil(LqryXmlImp);
  End;
end;

end.
