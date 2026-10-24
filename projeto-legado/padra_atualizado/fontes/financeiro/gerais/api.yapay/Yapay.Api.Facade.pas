unit Yapay.Api.Facade;

interface

uses
  System.SysUtils, System.Variants, Data.DB, Uni, TypInfo, System.StrUtils,
  System.Generics.Collections, RTTI, Forms, IniFiles, Winapi.Windows,
  System.Classes, cxLookAndFeelPainters, cxCheckComboBox,

  Yapay.Api.Conexao,
  Yapay.Api.Cobranca.Base,
  Yapay.Api.ErrorResponse,
  Yapay.Api.Ambiente,
  Yapay.Api.Envio.Cobranca.V3,
  Yapay.Api.Consulta.Cobranca.V3,
  Yapay.Api.Listagem.Transacoes,
  Yapay.Api.Inativar.Cobranca.V3,
  Yapay.Api.Tabela.Tabela3.FormasDePagamento,
  Yapay.Api.Tabela.Tabela4.StatusDaTransacao,
  Yapay.Api.TypeResponse,
  Yapay.Api.Resources,
  Yapay.Api.Core,

  untFuncoesSimples, UntMsgInterna;

type
  TYapayFacade = class
  public
    type
      TTipoSimNao = (Sim, Nao);

      TTipoSimNaoHelper = record helper for TTipoSimNao
      public
        function ToFlag: Char;
      end;

      TRespostaBaseComSucesso = TYapayApiRespostaBaseComSucesso;
      TRespostaBaseComErro = TYapayApiRespostaBaseComErro;
      TAmbiente = TYapayApiAmbiente;
      TRespostaConsultaCobrancaV3ComSucesso = TYapayApiRespostaConsultaCobrancaV3ComSucesso;

      TConexao = TYapayApiConexao;
      TEnvioCobranca = TYapayApiEnvioCobrancaV3;
      TConsultaCobranca = TYapayApiConsultaCobrancaV3;
      TCobrancaTransacao = TYapayApiRespostaConsultaCobrancaV3ComSucesso.TCobrancaTransacao;

      TListagemTransacoes = TYapayApiListagemTransacoes;

      {$M+}
      TPedido = class
      strict private
        function GetQuantidadeParcelas: integer;
        function GetFormasDePagamentoDisponiveis: TListFormasDePagamento;
      published
        property intQuantidadeParcelas: Integer read GetQuantidadeParcelas;
        property FormasDePagamentoDisponiveis: TListFormasDePagamento read GetFormasDePagamentoDisponiveis;
      public
        strAutIncFatGor: string;
        strCodCli: string;
        strCliNom: string;
        strCliEma: string;
        strNumDoc: string;
        strEspDoc: string;
        strEmpDoc: string;
        fltTotGer: Double;
        strCodVen: string;
        constructor Create(const pIntAutoIncCobranca: int64); overload;
      end;
      {$M-}

      TcxCheckComboBox = class sealed(cxCheckComboBox.TcxCheckComboBox)
      strict private
        function GetValue: string; reintroduce;
        procedure SetValue(const Value: string); reintroduce;
      public
        property Value: string read GetValue write SetValue;
        procedure PopulaFormasPagamento;
      end;

  strict private
    type
      EYapayFacade = class(Exception);

      TParametroTratarErrorResponse = record
        objErrors: TErrors;
        strContantError: string;
        strErro: string;
        strErroCode: string;
      end;

      TCfgMonitor = class abstract
      strict private
        class function GetExeName: string; static;
      public
        const
          strID_INACTIVITY_MONITOR = 'TEST_INACTIVITY_YAPAY_%s';
          intTIME_LIMIT_MONITOR = 30;
          strID_MONITOR = 'MONITOR_YAPAY_%s';
          intATTEMPTS_LOCK_MONITOR = 30;
          strPARAMS = 'YAPAY %s %s';

        class var objProcessoMonitor: TProcessInformation;
        class var dtaUltimaExecucaoMonitor: TDateTime;
        class var VS_strLockMonitor: String;

        class property ExeName: string read GetExeName;
      end;
    const
      strERROR_CREATE_NAO_PERMITIDO = 'Create da classe %s não permitido';
      strERROR_AUTHORIZATION = 'Falha ao autorizar aplicação revendedor!%s';
      strERROR_ACCESS_TOKEN = 'Falha ao obter token de acesso!%s';
      strERROR_ENVIO_COBRANCA = 'Erro de envio da Cobrança Yapay!%s';
      strERROR_CONSULTA_COBRANCA = 'Erro ao realizar consulta de Cobrança Yapay!%s';

      strCODE_ERROR_ENVIO_COBRANCA_PEDIDO_JA_EXISTENTE = '038010';

    var
      objConexao: TConexao;
      objEnvioCobranca: TEnvioCobranca;
      objConsultaCobranca: TConsultaCobranca;
      objListaCobrancas: TList<int64>;
      blnVerificarSeCobrancaPagaFoiCanceladaNaNuvem: boolean;

    procedure pCarregaParametrosConexao;
    function fAtivaConexao: Boolean;
    procedure pExibeMensagemErroConexao;
    function fOcorreramErrosAuthorization(out pStrErro: string): Boolean;
    function fOcorreramErrosAccessToken(out pStrErro: string): Boolean;

    function fTrataErrorResponse(var pObjParametro: TParametroTratarErrorResponse): Boolean;

    function fEnviarCobrancaPedido(pObjPedido: TPedido): Boolean;
    procedure pCarregaParametrosEnvioCobranca(pObjPedido: TPedido);
    procedure pExibeMensagemErroEnvioCobranca(pStrErro: string);
    function fOcorreramErrosEnvioCobranca(out pStrErro: string; out pStrErroCode: string): Boolean;
    procedure pGravaCobrancaPendente(const pStrAutIncFatGor: string);
    procedure pGravaCobrancaEnviada(const pStrAutIncFatGor: string);
    procedure pLimpaValoresFieldsDataset(const pObjDataset: TDataSet);
    function fEmailParaEnvioCorrigido(const pStrCliEma: string): string;

    function fPopulaListaCobrancasConsultar: Boolean;
    function fPopulaListaCobrancasPagasConsultar(const pStrAutIncFatGor: string): Boolean;

    procedure pConsultaListaCobrancas(const pBlnExibeMensagemErro: Boolean);

    procedure pExibeMensagemErroCobrancasConsultadas;
    function fOcorreramErrosCobrancasConsultadas(out pStrErro: string): Boolean;

    function fConsultaCobrancaPorID(pIntID: int64): Boolean;
    procedure pAtualizaCobrancaConsultada;
    procedure pGravaTransacoesCobrancaConsultada;
    function fGravarDetalhesPagamentoCobranca(pObjTransacao: TCobrancaTransacao; objQryCobranca: TUniQuery): Boolean;
    function fLancaAdiantamentoCliente(pObjTransacao: TCobrancaTransacao): Boolean;

    function fGetAutIncCobrancaById(pIntId: int64): string;

    class function fEnviaCobrancasPendentes: Boolean;

    constructor CreatePrivate;

    procedure pAtualizaLinksApi;

    class function fVerificarSeCobrancaPagaFoiCanceladaNaNuvem(
      const pStrAutIncFatGor: string; out pStrRetornoErro: string): boolean;

    procedure pDesativaCobrancaPedido(pObjPedido: TPedido);

  private
    type
      TDao = class abstract
      public
        type
          TQuery = class abstract(TUniQuery)
          public
            class function fFactory: TQuery;
          end;
      end;

      TMonitorLib = class abstract
      private
        class procedure GravaLog(const pstrProcName, pStrMensagem: string);
        class function fExecuteConsultaCobrancas: Boolean;
        class function fExecuteEnviaCobrancasPendentes: Boolean;
      end;

  public
    class var
      objCfgMonitor: TCfgMonitor;

    class function fPedidoFoiEnviado(const pStrAutIncFatGor: string): Boolean;

    class function fPedidoPossuiCobrancaAtiva(const pStrNumeroDocumento,
      pStrEspecie, pStrEmpresa: string): Boolean; overload;

    class function fPedidoPossuiCobrancaAtiva(
      const pStrAutIncFatGor: string): Boolean; overload;

    class function fPedidoComVinculoYapay(const strNumDoc, strEspDoc, strCodEmp: string): Boolean;

    class function fPedidoFoiPago(const pStrNumeroDocumento,
      pStrEspecie, pStrEmpresa: string): Boolean;

    class function fEnviaCobranca(pObjPedido: TPedido;
      const pBlnPrecisaVerificarSefoiEnviado, pBlnExibirMensagens: Boolean): Boolean;

    class function fConsultaCobrancas(const pBlnExibeMensagemErro: Boolean): Boolean;

    class function fLinkPagamento(const pStrAutIncFatGor: string): string;

    class function fCondicaoPagamentoGeraCobranca(const pStrCondicaoPagamento: string): Boolean;

    class function fPedidoPodeSerCancelado(const pStrNumeroDocumento,
      pStrEspecie, pStrEmpresa: string; out pStrRetornoErro: string): Boolean;

    class function fExecutaRotinasMonitor: Boolean;

    class function fGetAutIncFatGor(const pStrNumeroDocumento,
      pStrEspecie, pStrEmpresa: string): string;

    class function fVerificaExistenciaRestDLL: Boolean;

    class function fAdiantamentoVinculadoCobrancaParaEstorno(pStrAutoIncrem: string): boolean;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses untAdiantamentoCliente;

constructor TYapayFacade.CreatePrivate;
begin
  inherited Create;
  objConexao := TConexao.Create;
  pCarregaParametrosConexao;
  objListaCobrancas := TList<int64>.Create;
  pAtualizaLinksApi;
  blnVerificarSeCobrancaPagaFoiCanceladaNaNuvem := False;
end;

procedure TYapayFacade.pAtualizaLinksApi;

  procedure SetResourceString(xOldResourceString: PResStringRec; xValueChanged: PChar);
  var
    POldProtect: DWORD;
  begin
    VirtualProtect(xOldResourceString, SizeOf(xOldResourceString^), PAGE_EXECUTE_READWRITE, @POldProtect);
    xOldResourceString^.Identifier := Integer(xValueChanged);
    VirtualProtect(xOldResourceString,SizeOf(xOldResourceString^),POldProtect, @POldProtect);
  end;

begin
  SetResourceString(@rsYAPAY_API_AUTORIZAR_APLICACAO_REVENDEDOR_ENDERECO_SANDBOX, PChar(VarToStr(fCfgSis('YAPESA'))));
  SetResourceString(@rsYAPAY_API_AUTORIZAR_APLICACAO_REVENDEDOR_ENDERECO_PRODUCAO, PChar(VarToStr(fCfgSis('YAPEPA'))));

  SetResourceString(@rsYAPAY_API_TOKEN_DE_ACESSO_ENDERECO_SANDBOX, PChar(VarToStr(fCfgSis('YAPEST'))));
  SetResourceString(@rsYAPAY_API_TOKEN_DE_ACESSO_ENDERECO_PRODUCAO, PChar(VarToStr(fCfgSis('YAPEPT'))));

  SetResourceString(@rsYAPAY_API_ENVIO_COBRANCA_V3_ENDERECO_SANDBOX, PChar(VarToStr(fCfgSis('YAPESE'))));
  SetResourceString(@rsYAPAY_API_ENVIO_COBRANCA_V3_ENDERECO_PRODUCAO, PChar(VarToStr(fCfgSis('YAPEPE'))));

  SetResourceString(@rsYAPAY_API_CONSULTA_COBRANCA_V3_ENDERECO_SANDBOX, PChar(VarToStr(fCfgSis('YAPESC'))));
  SetResourceString(@rsYAPAY_API_CONSULTA_COBRANCA_V3_ENDERECO_PRODUCAO, PChar(VarToStr(fCfgSis('YAPEPC'))));

  SetResourceString(@rsYAPAY_API_INATIVAR_COBRANCA_V3_ENDERECO_SANDBOX, PChar(VarToStr(fCfgSis('YAPESI'))));
  SetResourceString(@rsYAPAY_API_INATIVAR_COBRANCA_V3_ENDERECO_PRODUCAO, PChar(VarToStr(fCfgSis('YAPEPI'))));

  SetResourceString(@rsYAPAY_API_LISTAGEM_TRANSACOES_ENDERECO_SANDBOX, PChar(VarToStr(fCfgSis('YAPESL'))));
  SetResourceString(@rsYAPAY_API_LISTAGEM_TRANSACOES_ENDERECO_PRODUCAO, PChar(VarToStr(fCfgSis('YAPEPL'))));

end;

constructor TYapayFacade.Create;
begin
  raise EYapayFacade.CreateFmt(strERROR_CREATE_NAO_PERMITIDO, [Self.ClassName]);
end;

destructor TYapayFacade.Destroy;
begin
  if Assigned(objConexao) then
    FreeAndNil(objConexao);

  if Assigned(objEnvioCobranca) then
    FreeAndNil(objEnvioCobranca);

  if Assigned(objConsultaCobranca) then
    FreeAndNil(objConsultaCobranca);

  if Assigned(objListaCobrancas) then
    FreeAndNil(objListaCobrancas);

  inherited;
end;

class function TYapayFacade.fEnviaCobranca(pObjPedido: TPedido;
  const pBlnPrecisaVerificarSefoiEnviado, pBlnExibirMensagens: Boolean): Boolean;
var
  objYapay: TYapayFacade;
  strRetornoErro: string;
  strRetornoErroCode: string;
begin
  if not (fCfgSis('YAPHAB',varBoolean)) then
    exit(True);

  if (pBlnPrecisaVerificarSefoiEnviado) and (fPedidoFoiEnviado(pObjPedido.strAutIncFatGor)) then
    exit(false);

  objYapay := TYapayFacade.CreatePrivate;
  try
    if not objYapay.fAtivaConexao then
    begin
      if pBlnExibirMensagens then
        objYapay.pExibeMensagemErroConexao;
      objYapay.pGravaCobrancaPendente(pObjPedido.strAutIncFatGor);
      exit(True)
    end;

    if not objYapay.fEnviarCobrancaPedido(pObjPedido) then
    begin
      if objYapay.fOcorreramErrosEnvioCobranca(strRetornoErro, strRetornoErroCode) then
      begin
        if pBlnExibirMensagens then
          objYapay.pExibeMensagemErroEnvioCobranca(strRetornoErro);

        if Pos(strCODE_ERROR_ENVIO_COBRANCA_PEDIDO_JA_EXISTENTE, strRetornoErroCode) > 0 then
          objYapay.pDesativaCobrancaPedido(pObjPedido);
      end;
      exit(False);
    end;

    objYapay.pGravaCobrancaEnviada(pObjPedido.strAutIncFatGor);
    result := True;

  finally
    if Assigned(objYapay) then
      FreeAndNil(objYapay);
  end;
end;

procedure TYapayFacade.pGravaCobrancaPendente(const pStrAutIncFatGor: string);
var
  objQryAux : TDao.TQuery;
begin
  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT AUTOINCREM,' + sLineBreak +
      '       FGO_SEQGER,' + sLineBreak +
      '       YCO_ENVDAT,' + sLineBreak +
      '       YCO_RESATV,' + sLineBreak +
      '       YCO_RESPAG' + sLineBreak +
      '  FROM YAPCOB' + sLineBreak +
      ' WHERE FGO_SEQGER = :FGO_SEQGER' + sLineBreak +
      '   AND YCO_RESATV = :YCO_RESATV';
    objQryAux.ParamByName('FGO_SEQGER').AsString := pStrAutIncFatGor;
    objQryAux.ParamByName('YCO_RESATV').AsString := Sim.ToFlag;
    objQryAux.Open;
    if objQryAux.IsEmpty then
    begin
      objQryAux.Insert;
      objQryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('YAPCOB',VS_strCodEmp);
    end
    else
      objQryAux.Edit;

    pLimpaValoresFieldsDataset(objQryAux);

    objQryAux.FieldByName('FGO_SEQGER').AsString := objQryAux.ParamByName('FGO_SEQGER').AsString;
    objQryAux.FieldByName('YCO_ENVDAT').AsDateTime := fnow;

    objQryAux.FieldByName('YCO_RESATV').AsString := Sim.ToFlag;
    objQryAux.FieldByName('YCO_RESPAG').AsString := Nao.ToFlag;

    objQryAux.Post;
    objQryAux.Close;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;
end;

procedure TYapayFacade.pLimpaValoresFieldsDataset(const pObjDataset: TDataSet);
var
  I: Integer;
begin
  for I := 0 to pObjDataset.Fields.Count - 1 do
  begin
    if CompareText(pObjDataset.Fields[i].FieldName, 'AUTOINCREM') <> 0 then
        pObjDataset.Fields[i].Clear;
  end;
end;

procedure TYapayFacade.pGravaCobrancaEnviada(const pStrAutIncFatGor: string);
var
  objQryAux : TDao.TQuery;
  objRespostaCobranca: TRespostaBaseComSucesso;
begin
  objRespostaCobranca := TRespostaBaseComSucesso(objEnvioCobranca.Resposta);
  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT *' + sLineBreak +
      '  FROM YAPCOB' + sLineBreak +
      ' WHERE FGO_SEQGER = :FGO_SEQGER' + sLineBreak +
      '   AND YCO_RESATV = :YCO_RESATV';
    objQryAux.ParamByName('FGO_SEQGER').AsString := pStrAutIncFatGor;
    objQryAux.ParamByName('YCO_RESATV').AsString := Sim.ToFlag;
    objQryAux.Open;
    if objQryAux.IsEmpty then
    begin
      objQryAux.Insert;
      objQryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('YAPCOB',VS_strCodEmp);
    end
    else
      objQryAux.Edit;

    pLimpaValoresFieldsDataset(objQryAux);

    objQryAux.FieldByName('FGO_SEQGER').AsString := objQryAux.ParamByName('FGO_SEQGER').AsString;
    objQryAux.FieldByName('YCO_ENVACT').AsString := objEnvioCobranca.TabelaParametros.Access_token;
    objQryAux.FieldByName('YCO_ENVONU').AsString := objEnvioCobranca.TabelaParametros.Order_number;
    objQryAux.FieldByName('YCO_ENVCOD').AsString := objEnvioCobranca.TabelaParametros.Code;
    objQryAux.FieldByName('YCO_ENVVAL').AsFloat := objEnvioCobranca.TabelaParametros.Value;
    objQryAux.FieldByName('YCO_ENVDES').AsString := objEnvioCobranca.TabelaParametros.Description;
    if objEnvioCobranca.TabelaParametros.Max_split_transaction = 0 then
      objQryAux.FieldByName('YCO_ENVMST').Clear
    else
      objQryAux.FieldByName('YCO_ENVMST').AsLargeInt := objEnvioCobranca.TabelaParametros.Max_split_transaction;
    objQryAux.FieldByName('YCO_ENVAPM').AsString := objEnvioCobranca.TabelaParametros.Available_payment_methods.ToString;
    objQryAux.FieldByName('YCO_ENVNCH').AsString := BoolToStr(objEnvioCobranca.TabelaParametros.New_checkout, true).ToLower;
    objQryAux.FieldByName('YCO_ENVUCA').AsString := BoolToStr(objEnvioCobranca.TabelaParametros.Use_cards, true).ToLower;
    objQryAux.FieldByName('YCO_ENVCEM').AsString := objEnvioCobranca.TabelaParametros.Customer_email;
    objQryAux.FieldByName('YCO_ENVJSO').AsString := objEnvioCobranca.JSONEnvio;
    objQryAux.FieldByName('YCO_ENVDAT').AsDateTime := fnow;

    objQryAux.FieldByName('YCO_RESRES').AsString := objRespostaCobranca.Resource;
    objQryAux.FieldByName('YCO_RESID_').AsLargeInt := objRespostaCobranca.Id;
    objQryAux.FieldByName('YCO_RESONU').AsString := objRespostaCobranca.Order_number;
    objQryAux.FieldByName('YCO_RESCOD').AsString := objRespostaCobranca.Code;
    objQryAux.FieldByName('YCO_RESVAL').AsFloat := objRespostaCobranca.Value;
    objQryAux.FieldByName('YCO_RESDES').AsString := objRespostaCobranca.Description;
    if objRespostaCobranca.Max_split_transaction = 0 then
      objQryAux.FieldByName('YCO_RESMST').Clear
    else
      objQryAux.FieldByName('YCO_RESMST').AsLargeInt := objRespostaCobranca.Max_split_transaction;
    objQryAux.FieldByName('YCO_RESAPM').AsString := objRespostaCobranca.Available_payment_methods.ToString;
    objQryAux.FieldByName('YCO_RESPLI').AsString := objRespostaCobranca.Payment_link;
    objQryAux.FieldByName('YCO_RESSTA').AsString := BoolToStr(objRespostaCobranca.Status, true).ToLower;
    objQryAux.FieldByName('YCO_RESCRA').AsLargeInt := objRespostaCobranca.Created_at;

    objQryAux.FieldByName('YCO_RESJSO').AsString := objEnvioCobranca.JSONRetorno;
    objQryAux.FieldByName('YCO_RESDAT').AsDateTime := fNow;

    objQryAux.FieldByName('YCO_RESATV').AsString := Sim.ToFlag;
    objQryAux.FieldByName('YCO_RESPAG').AsString := Nao.ToFlag;

    objQryAux.FieldByName('YCO_AMBPRO').AsString :=
      ifthen(objEnvioCobranca.Conexao.Ambiente = Producao,
             Sim.ToFlag,
             Nao.ToFlag);

    objQryAux.FieldByName('YCO_AMBURL').AsString := objEnvioCobranca.Endereco;

    objQryAux.Post;
    objQryAux.Close;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;
end;

function TYapayFacade.fEnviarCobrancaPedido(pObjPedido: TPedido): Boolean;
begin
  if Assigned(objEnvioCobranca) then
    FreeAndNil(objEnvioCobranca);
  objEnvioCobranca := TEnvioCobranca.Create;
  pCarregaParametrosEnvioCobranca(pObjPedido);
  Result := objEnvioCobranca.Enviar;
end;

function TYapayFacade.fEmailParaEnvioCorrigido(const pStrCliEma: string): string;
begin
  Result := trim(pStrCliEma);
  if pos(';', result) > 0 then
    Result := Copy(Result, 1, pos(';', result) - 1);
end;

procedure TYapayFacade.pCarregaParametrosEnvioCobranca(pObjPedido: TPedido);
begin
  objEnvioCobranca.Conexao := objConexao;
  objEnvioCobranca.TabelaParametros.Customer_email := fEmailParaEnvioCorrigido(pObjPedido.strCliEma);

  objEnvioCobranca.TabelaParametros.Order_number :=
    pObjPedido.strNumDoc + pObjPedido.strEspDoc + pObjPedido.strEmpDoc;

  objEnvioCobranca.TabelaParametros.Code := pObjPedido.strNumDoc;

  objEnvioCobranca.TabelaParametros.Value := pObjPedido.fltTotGer;

  objEnvioCobranca.TabelaParametros.Description :=
    'Pedido de Venda nº ' + pObjPedido.strNumDoc +
    '-' + pObjPedido.strEspDoc +
    '-' + pObjPedido.strEmpDoc;

  if objEnvioCobranca.Conexao.Ambiente = Sandbox then
    objEnvioCobranca.TabelaParametros.Description :=
      objEnvioCobranca.TabelaParametros.Description + ' (Homologação)';

  objEnvioCobranca.TabelaParametros.Max_split_transaction := pObjPedido.intQuantidadeParcelas;

  objEnvioCobranca.TabelaParametros.Available_payment_methods := pObjPedido.FormasDePagamentoDisponiveis;

  objEnvioCobranca.TabelaParametros.New_checkout := False;
  objEnvioCobranca.TabelaParametros.Use_cards := False;
end;

procedure TYapayFacade.pExibeMensagemErroEnvioCobranca(pStrErro: string);
begin
  fMensagem('Yapay', pStrErro,['&OK']);
end;

function TYapayFacade.fOcorreramErrosEnvioCobranca(out pStrErro: string; out pStrErroCode: string): Boolean;
var
  objParametro: TParametroTratarErrorResponse;
begin
  objParametro.objErrors := TRespostaBaseComErro(objEnvioCobranca.Resposta).Errors;
  objParametro.strContantError := strERROR_ENVIO_COBRANCA;
  objParametro.strErro := pStrErro;
  Result := fTrataErrorResponse(objParametro);
  pStrErro := objParametro.strErro;
  pStrErroCode := objParametro.strErroCode;
end;

function TYapayFacade.fAtivaConexao: Boolean;
begin
  try
    objConexao.Active := True;
    result := objConexao.Active;
  except
    result := False;
  end;
end;

class function TYapayFacade.fLinkPagamento(const pStrAutIncFatGor: string): string;
begin
  result := fCampoTabela('YCO_RESPLI',
                         'YAPCOB',
                         ['FGO_SEQGER', 'YCO_RESATV'],
                         [pStrAutIncFatGor, Sim.ToFlag]);
end;

class function TYapayFacade.fPedidoPodeSerCancelado(const pStrNumeroDocumento,
  pStrEspecie, pStrEmpresa: string; out pStrRetornoErro: string): Boolean;
var
  strAutIncFatGor: string;
const
  strMENSAGEM_POSSUI_COBRANCA_ATIVA = 'Pedido possuí Cobrança Yapay com status local Ativa e não pode ser alterado/cancelado! ';
begin
  strAutIncFatGor := fGetAutIncFatGor(pStrNumeroDocumento, pStrEspecie, pStrEmpresa);
  result := not fPedidoPossuiCobrancaAtiva(strAutIncFatGor);
  if result then
    Exit;
  result := fVerificarSeCobrancaPagaFoiCanceladaNaNuvem(strAutIncFatGor, pStrRetornoErro);
  pStrRetornoErro := strMENSAGEM_POSSUI_COBRANCA_ATIVA + sLineBreak + sLineBreak + pStrRetornoErro;
end;

class function TYapayFacade.fGetAutIncFatGor(const pStrNumeroDocumento,
  pStrEspecie, pStrEmpresa: string): string;
begin
  If fEmptyStr(pStrNumeroDocumento) Then
    Exit('');

  result := fCampoTabela('AUTOINCREM',
                         'FATGOR',
                         ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                         [pStrNumeroDocumento, pStrEspecie, pStrEmpresa]);
end;

class function TYapayFacade.fPedidoPossuiCobrancaAtiva(const pStrNumeroDocumento,
  pStrEspecie, pStrEmpresa: string): Boolean;
begin
  result := fPedidoPossuiCobrancaAtiva(fGetAutIncFatGor(pStrNumeroDocumento, pStrEspecie, pStrEmpresa));
end;

class function TYapayFacade.fPedidoPossuiCobrancaAtiva(
  const pStrAutIncFatGor: string): Boolean;
var
  objQryAux : TDao.TQuery;
begin
  if pStrAutIncFatGor.IsEmpty then
    Exit(False);

  if not (fCfgSis('YAPHAB',varBoolean)) then
    Exit(False);

  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT 1' + sLineBreak +
      '  FROM FATGOR' + sLineBreak +
      '  JOIN YAPCOB' + sLineBreak +
      '    ON YAPCOB.FGO_SEQGER = FATGOR.AUTOINCREM' + sLineBreak +
      ' WHERE FATGOR.AUTOINCREM = :AUTOINCREM' + sLineBreak +
      '   AND YAPCOB.YCO_RESATV = :YCO_RESATV';
    objQryAux.ParamByName('AUTOINCREM').AsString := pStrAutIncFatGor;
    objQryAux.ParamByName('YCO_RESATV').AsString := Sim.ToFlag;
    objQryAux.Open;
    result := not objQryAux.IsEmpty;
    objQryAux.Close;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;
end;

class function TYapayFacade.fPedidoComVinculoYapay(const strNumDoc, strEspDoc, strCodEmp: string): Boolean;
  Var
    objQryAux : TDao.TQuery;
begin
  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      ' SELECT FATGOR.AUTOINCREM ' +
      '   FROM FATGOR ' +
      '   JOIN YAPCOB ON YAPCOB.FGO_SEQGER = FATGOR.AUTOINCREM ' +
      '  WHERE FATGOR.FGO_NUMDOC = :NUMDOC ' +
      '    AND FATGOR.FGO_ESPDOC = :ESPDOC ' +
      '    AND FATGOR.FGO_CODEMP = :CODEMP ';
    objQryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    objQryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    objQryAux.ParamByName('CODEMP').AsString := strCodEmp;
    objQryAux.Open;
    Result := (Not objQryAux.IsEmpty);
    objQryAux.Close;
  finally
    FreeAndNil(objQryAux);
  end;
end;

class function TYapayFacade.fCondicaoPagamentoGeraCobranca(const pStrCondicaoPagamento: string): Boolean;
begin
  result := (fCfgSis('YAPHAB',varBoolean)) and
            (fCampoTabela('CND_COBYAP', 'CADCND', ['CND_CODIGO'], [pStrCondicaoPagamento]) = Sim.ToFlag);
end;

class function TYapayFacade.fPedidoFoiEnviado(const pStrAutIncFatGor: string): Boolean;
var
  objQryAux : TDao.TQuery;
begin
  if pStrAutIncFatGor.IsEmpty then
    Exit(false);

  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT YCO_RESID_,' + sLineBreak +
      '       YCO_ENVDAT,' + sLineBreak +
      '       YCO_RESPLI' + sLineBreak +
      '  FROM YAPCOB' + sLineBreak +
      ' WHERE FGO_SEQGER = :FGO_SEQGER' + sLineBreak +
      '   AND YCO_RESATV = :YCO_RESATV';
    objQryAux.ParamByName('FGO_SEQGER').AsString := pStrAutIncFatGor;
    objQryAux.ParamByName('YCO_RESATV').AsString := Sim.ToFlag;
    objQryAux.Open;
    result := not objQryAux.FieldByName('YCO_RESID_').IsNull;

    if Result then
    begin
      fMensagem('Yapay',
                'Pedido possuí Cobrança Yapay e não pode ser alterado/cancelado!' + sLineBreak +
                'Cobrança id: ' + objQryAux.FieldByName('YCO_RESID_').AsString + sLineBreak +
                'Data/Hora: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', objQryAux.FieldByName('YCO_ENVDAT').AsDateTime) + sLineBreak +
                'Link: ' + objQryAux.FieldByName('YCO_RESPLI').AsString,
                ['&OK']);
    end;

    objQryAux.Close;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;
end;

class function TYapayFacade.fPedidoFoiPago(const pStrNumeroDocumento,
  pStrEspecie, pStrEmpresa: string): Boolean;
var
  objQryAux : TDao.TQuery;
begin
  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT YCO_RESPAG,' + sLineBreak +
      '       YCO_RESATV' + sLineBreak +
      '  FROM FATGOR' + sLineBreak +
      '  JOIN YAPCOB' + sLineBreak +
      '    ON YAPCOB.FGO_SEQGER = FATGOR.AUTOINCREM' + sLineBreak +
      ' WHERE FATGOR.FGO_NUMDOC = :FGO_NUMDOC' + sLineBreak +
      '   AND FATGOR.FGO_ESPDOC = :FGO_ESPDOC' + sLineBreak +
      '   AND FATGOR.FGO_CODEMP = :FGO_CODEMP' + sLineBreak +
      '   AND YAPCOB.YCO_RESATV = :YCO_RESATV';
    objQryAux.ParamByName('FGO_NUMDOC').AsString := pStrNumeroDocumento;
    objQryAux.ParamByName('FGO_ESPDOC').AsString := pStrEspecie;
    objQryAux.ParamByName('FGO_CODEMP').AsString := pStrEmpresa;
    objQryAux.ParamByName('YCO_RESATV').AsString := Sim.ToFlag;
    objQryAux.Open;
    objQryAux.First;

    Result := (CompareText(objQryAux.FieldByName('YCO_RESPAG').AsString, Sim.ToFlag) = 0);

    objQryAux.Close;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;

end;

procedure TYapayFacade.pCarregaParametrosConexao;
{$IFNDEF LINUX}
var
  objIniYapay: TIniFile;
{$ENDIF LINUX}
begin
{$IFNDEF LINUX}
  objIniYapay := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\opcoes_yapay.ini');
  try
    if not objIniYapay.ValueExists('API YAPAY', 'Debug') then
      objIniYapay.WriteString('API YAPAY', 'Debug', Nao.ToFlag);
    objConexao.Debug := CompareText(objIniYapay.ReadString('API YAPAY', 'Debug', Nao.ToFlag), Sim.ToFlag) = 0;

    if not objIniYapay.ValueExists('API YAPAY', 'Log') then
      objIniYapay.WriteString('API YAPAY', 'Log', Nao.ToFlag);
    objConexao.Log := CompareText(objIniYapay.ReadString('API YAPAY', 'Log', Nao.ToFlag), Sim.ToFlag) = 0;
  finally
    if Assigned(objIniYapay) then
      FreeAndNil(objIniYapay);
  end;
{$ENDIF LINUX}

  objConexao.Ambiente := TAmbiente(StrToIntDef(fCfgSis('YAPAMB'), 0));
  objConexao.Consumer_key := fCfgSis('YAPCUK');
  objConexao.Consumer_secret := fCfgSis('YAPCUS');
  objConexao.Reseller_token := fCfgSis('YAPRET');
  objConexao.Token_account := fCfgSis('YAPTOA');
  objConexao.Type_response := TTypeResponse.JSON;
end;

procedure TYapayFacade.pExibeMensagemErroConexao;
var
  strRetornoErro: string;
begin
  if (fOcorreramErrosAuthorization(strRetornoErro)) or
     (fOcorreramErrosAccessToken(strRetornoErro)) then
  begin
    fMensagem('Yapay', strRetornoErro,['&OK']);
  end;
end;

function TYapayFacade.fOcorreramErrosAuthorization(out pStrErro: string): Boolean;
var
  objParametro: TParametroTratarErrorResponse;
begin
  objParametro.objErrors := objConexao.Authorization.Error_Response.General_errors;
  objParametro.strContantError := strERROR_AUTHORIZATION;
  objParametro.strErro := pStrErro;
  Result := fTrataErrorResponse(objParametro);
  pStrErro := objParametro.strErro;
end;

function TYapayFacade.fOcorreramErrosAccessToken(out pStrErro: string): Boolean;
var
  objParametro: TParametroTratarErrorResponse;
begin
  objParametro.objErrors := objConexao.Token.Error_Response.General_errors;
  objParametro.strContantError := strERROR_ACCESS_TOKEN;
  objParametro.strErro := pStrErro;
  Result := fTrataErrorResponse(objParametro);
  pStrErro := objParametro.strErro;
end;

function TYapayFacade.fTrataErrorResponse(var pObjParametro: TParametroTratarErrorResponse): Boolean;
var
  objErro: TGeneralError;
begin
  pObjParametro.strErro := NullAsStringValue;
  if pObjParametro.objErrors.Count = 0 then
    exit(False);

  Result := True;
  for objErro in pObjParametro.objErrors do
  begin
    pObjParametro.StrErro := pObjParametro.StrErro +
      'Code: ' + objErro.Code + sLineBreak +
      'Messagem: ' + objErro.Message + sLineBreak + sLineBreak;

    pObjParametro.strErroCode := pObjParametro.strErroCode + objErro.Code + '_';
  end;

  pObjParametro.StrErro :=
    Format(pObjParametro.strContantError,
           [sLineBreak + pObjParametro.StrErro]);
end;

function TYapayFacade.TTipoSimNaoHelper.ToFlag: Char;
begin
  result := GetEnumName(TypeInfo(TYapayFacade.TTipoSimNao), integer(Self))[1];
end;

class function TYapayFacade.fConsultaCobrancas(
  const pBlnExibeMensagemErro: Boolean): Boolean;
var
  objYapay: TYapayFacade;
begin
  if not (fCfgSis('YAPHAB',varBoolean)) then
    exit(True);

  objYapay := TYapayFacade.CreatePrivate;
  try
    if not objYapay.fPopulaListaCobrancasConsultar then
      exit(False);

    if not objYapay.fAtivaConexao then
    begin
      if pBlnExibeMensagemErro then
        objYapay.pExibeMensagemErroConexao;
      exit(False)
    end;

    objYapay.pConsultaListaCobrancas(pBlnExibeMensagemErro);
    result := True;
  finally
    if Assigned(objYapay) then
      FreeAndNil(objYapay);
  end;
end;

class function TYapayFacade.fVerificarSeCobrancaPagaFoiCanceladaNaNuvem(
  const pStrAutIncFatGor: string; out pStrRetornoErro: string): boolean;
const
  strMENSAGEM_NAO_FOI_POSSIVEL_CONSULTAR = 'Não foi possível sincronizar Status da Cobrança Yapay na nuvem. ';
var
  objYapay: TYapayFacade;
  blnAtivaConexao: boolean;

begin
  if not (fCfgSis('YAPHAB',varBoolean)) then
    exit(True);

  pStrRetornoErro := String.Empty;
  objYapay := TYapayFacade.CreatePrivate;
  try
    try
      blnAtivaConexao := objYapay.fAtivaConexao;
    except
      on E: Exception do
      begin
        pStrRetornoErro := strMENSAGEM_NAO_FOI_POSSIVEL_CONSULTAR + sLineBreak +
                           'Erro: ' + E.message + sLineBreak +
                           'Caso o Pagamento do Pedido tenha sido cancelado no Portal da Yapay, realize a Sincronização do Status em outro computador.';
        Exit(False);
      end;
    end;

    if not blnAtivaConexao then
    begin
      if objYapay.fOcorreramErrosAuthorization(pStrRetornoErro) or
         objYapay.fOcorreramErrosAccessToken(pStrRetornoErro) then
      begin
        pStrRetornoErro := strMENSAGEM_NAO_FOI_POSSIVEL_CONSULTAR + sLineBreak +
                           pStrRetornoErro +
                           'Ajuste as configurações de integração do Yapay.';
      end;
      exit(False)
    end;

    if not objYapay.fPopulaListaCobrancasPagasConsultar(pStrAutIncFatGor) then
      exit(False);

    objYapay.blnVerificarSeCobrancaPagaFoiCanceladaNaNuvem := True;
    objYapay.pConsultaListaCobrancas(False);


    result := not fPedidoPossuiCobrancaAtiva(pStrAutIncFatGor);
  finally
    if Assigned(objYapay) then
      FreeAndNil(objYapay);
  end;
end;

function TYapayFacade.fPopulaListaCobrancasPagasConsultar(
  const pStrAutIncFatGor: string): Boolean;
var
  objQryAux: TDao.TQuery;
begin
  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT YAPCOB.AUTOINCREM,' + sLineBreak +
      '       YAPCOB.YCO_RESID_' + sLineBreak +
      '  FROM YAPCOB' + sLineBreak +
      '  JOIN FATGOR' + sLineBreak +
      '    ON FATGOR.AUTOINCREM = YAPCOB.FGO_SEQGER' + sLineBreak +
      ' WHERE YAPCOB.YCO_RESID_ IS NOT NULL' + sLineBreak +
      '   AND YAPCOB.YCO_RESATV = :YCO_RESATV' + sLineBreak +
      '   AND YAPCOB.YCO_RESPAG = :YCO_RESPAG' + sLineBreak +
      '   AND YAPCOB.YCO_AMBPRO = :YCO_AMBPRO' + sLineBreak +
      '   AND FATGOR.FGO_CODEMP = :FGO_CODEMP' + sLineBreak +
      '   AND FATGOR.AUTOINCREM = :AUTOINCREM';

    objQryAux.ParamByName('YCO_RESATV').AsString := Sim.ToFlag;
    objQryAux.ParamByName('YCO_RESPAG').AsString := Sim.ToFlag;
    objQryAux.ParamByName('YCO_AMBPRO').AsString :=
      ifthen(objConexao.Ambiente = Producao,
             Sim.ToFlag,
             Nao.ToFlag);
    objQryAux.ParamByName('FGO_CODEMP').AsString := VS_strCodEmp;
    objQryAux.ParamByName('AUTOINCREM').AsString := pStrAutIncFatGor;
    objQryAux.Open;
    objQryAux.First;
    objListaCobrancas.Clear;
    while not objQryAux.Eof do
    begin
      objListaCobrancas.Add(objQryAux.FieldByName('YCO_RESID_').AsLargeInt);
      objQryAux.Next;
    end;
    objQryAux.Close;
    Result := True;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;
end;

function TYapayFacade.fPopulaListaCobrancasConsultar: Boolean;
var
  objQryAux: TDao.TQuery;
begin
  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT YAPCOB.AUTOINCREM,' + sLineBreak +
      '       YAPCOB.YCO_RESID_' + sLineBreak +
      '  FROM YAPCOB' + sLineBreak +
      '  JOIN FATGOR' + sLineBreak +
      '    ON FATGOR.AUTOINCREM = YAPCOB.FGO_SEQGER' + sLineBreak +
      ' WHERE YAPCOB.YCO_RESID_ IS NOT NULL' + sLineBreak +
      '   AND YAPCOB.YCO_RESATV = :YCO_RESATV' + sLineBreak +
      '   AND YAPCOB.YCO_RESPAG = :YCO_RESPAG' + sLineBreak +
      '   AND YAPCOB.YCO_AMBPRO = :YCO_AMBPRO' + sLineBreak +
      '   AND FATGOR.FGO_CODEMP = :FGO_CODEMP';
    objQryAux.ParamByName('YCO_RESATV').AsString := Sim.ToFlag;
    objQryAux.ParamByName('YCO_RESPAG').AsString := Nao.ToFlag;
    objQryAux.ParamByName('YCO_AMBPRO').AsString :=
      ifthen(objConexao.Ambiente = Producao,
             Sim.ToFlag,
             Nao.ToFlag);
    objQryAux.ParamByName('FGO_CODEMP').AsString := VS_strCodEmp;
    objQryAux.Open;
    objQryAux.First;
    objListaCobrancas.Clear;
    while not objQryAux.Eof do
    begin
      objListaCobrancas.Add(objQryAux.FieldByName('YCO_RESID_').AsLargeInt);
      objQryAux.Next;
    end;

    Result := (not objQryAux.IsEmpty);

    objQryAux.Close;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;
end;

procedure TYapayFacade.pConsultaListaCobrancas(const pBlnExibeMensagemErro: Boolean);
var
  intID: int64;
begin
  for intID in objListaCobrancas do
  begin
    if not fConsultaCobrancaPorID(intID) then
    begin
      if pBlnExibeMensagemErro then
        pExibeMensagemErroCobrancasConsultadas;
      Break;
    end;

    pAtualizaCobrancaConsultada;
    pGravaTransacoesCobrancaConsultada;
    pZerarTentativasLock(Format(TYapayFacade.objCfgMonitor.strID_MONITOR, [VS_strCodEmp]));
  end;
end;

procedure TYapayFacade.pDesativaCobrancaPedido(pObjPedido: TPedido);
var
  objQryAux : TDao.TQuery;
begin
  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.Close;
    objQryAux.SQL.Text :=
    ' UPDATE '+ sLineBreak +
    '   YAPCOB '+ sLineBreak +
    ' SET '+ sLineBreak +
    '   YCO_RESATV = :YCO_RESATV '+ sLineBreak +
    ' WHERE '+ sLineBreak +
    '   FGO_SEQGER = :FGO_SEQGER ';

    objQryAux.ParamByName('YCO_RESATV').AsString := Nao.ToFlag;
    objQryAux.ParamByName('FGO_SEQGER').AsString := pObjPedido.strAutIncFatGor;
    objQryAux.ExecSQL;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;
end;

procedure TYapayFacade.pExibeMensagemErroCobrancasConsultadas;
var
  strRetornoErro: string;
begin
  if (fOcorreramErrosCobrancasConsultadas(strRetornoErro)) then
    fMensagem('Yapay', strRetornoErro,['&OK']);
end;

function TYapayFacade.fOcorreramErrosCobrancasConsultadas(out pStrErro: string): Boolean;
var
  objParametro: TParametroTratarErrorResponse;
begin
  objParametro.objErrors := TRespostaBaseComErro(objConsultaCobranca.Resposta).Errors;
  objParametro.strContantError := strERROR_CONSULTA_COBRANCA;
  objParametro.strErro := pStrErro;
  Result := fTrataErrorResponse(objParametro);
  pStrErro := objParametro.strErro;
end;

function TYapayFacade.fConsultaCobrancaPorID(pIntID: int64): Boolean;
begin
  if Assigned(objConsultaCobranca) then
    FreeAndNil(objConsultaCobranca);
  objConsultaCobranca := TConsultaCobranca.Create;
  objConsultaCobranca.TabelaParametros.Id := pIntID;
  objConsultaCobranca.Conexao := objConexao;
  Result := objConsultaCobranca.Enviar;
end;

procedure TYapayFacade.pAtualizaCobrancaConsultada;
var
  objQryAux : TDao.TQuery;
  objResposta: TRespostaConsultaCobrancaV3ComSucesso;

  procedure pAtualizaCampoStatus;
  begin
    if CompareText(objQryAux.FieldByName('YCO_RESSTA').AsString, BoolToStr(objResposta.Status, true)) <> 0 then
    begin
      objQryAux.Edit;
      objQryAux.FieldByName('YCO_RESSTA').AsString := BoolToStr(objResposta.Status, true).ToLower;
      objQryAux.Post;
    end;
  end;

  procedure pAtualizaCampoAtivaSim;
  begin
    if (objResposta.Status) and
       (CompareText(objQryAux.FieldByName('YCO_RESATV').AsString, Sim.ToFlag) <> 0) then
    begin
      objQryAux.Edit;
      objQryAux.FieldByName('YCO_RESATV').AsString := Sim.ToFlag;
      objQryAux.Post;
    end;
  end;

  function fGeraConteudoMensagem(pObjPedido: TPedido): string;
  begin
    Result :=
      'Cancelamento de Cobrança Yapay: Pedido ' +
      pObjPedido.strNumDoc + '-' +
      pObjPedido.strEspDoc + '-' +
      pObjPedido.strEmpDoc + sLineBreak + sLineBreak +
      '-------------------------------------------------------------------- ' + sLineBreak +
      '                         Dados Autcom                                ' + sLineBreak +
      '-------------------------------------------------------------------- ' + sLineBreak +
      'Pedido: ' + pObjPedido.strNumDoc + '-' + pObjPedido.strEspDoc + '-' + pObjPedido.strEmpDoc + sLineBreak +
      'Nome do Cliente: ' + pObjPedido.strCodCli + '-' + pObjPedido.strCliNom + sLineBreak + sLineBreak +
      '-------------------------------------------------------------------- ' + sLineBreak +
      '                         Dados Yapay                                 ' + sLineBreak +
      '-------------------------------------------------------------------- ' + sLineBreak +
      'Cobrança Id: ' + objConsultaCobranca.TabelaParametros.Id.ToString + sLineBreak +
      'Email (Conta Yapay): ' + objResposta.Email_customer + sLineBreak +
      'Valor Cobrança: ' + FormatFloat('R$ 0.00#,##', objResposta.Value);
  end;

  procedure pAtualizaCampoAtivaNao;
  var
    objMsgInterna: TMsgInterna;
    strAssunto: string;
    objPedido: TPedido;
  begin
    if (not objResposta.Status) and
       (CompareText(objQryAux.FieldByName('YCO_RESATV').AsString, Nao.ToFlag) <> 0) then
    begin
      objQryAux.Edit;
      objQryAux.FieldByName('YCO_RESATV').AsString := Nao.ToFlag;
      objQryAux.Post;

      objPedido := TPedido.Create(objConsultaCobranca.TabelaParametros.Id);
      objMsgInterna := TMsgInterna.Create(Application.MainForm);
      try
        strAssunto :=
          'Cancelamento de Cobrança Yapay: Pedido ' +
          objPedido.strNumDoc + '-' +
          objPedido.strEspDoc + '-' +
          objPedido.strEmpDoc;

        objMsgInterna.fEnviaMensagem(
          strAssunto,
          fGeraConteudoMensagem(objPedido),
          fCfgSis('YAPOPE'),
          objPedido.strCodVen,
          'N',
          NullAsStringValue);
      finally
        if Assigned(objMsgInterna) then
          FreeAndNil(objMsgInterna);

        if Assigned(objPedido) then
          FreeAndNil(objPedido);
      end;

    end;
  end;

begin
  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT AUTOINCREM,' + sLineBreak +
      '       YCO_ENVONU,' + sLineBreak +
      '       YCO_RESID_,' + sLineBreak +
      '       YCO_RESSTA,' + sLineBreak +
      '       YCO_RESATV' + sLineBreak +
      '  FROM YAPCOB' + sLineBreak +
      ' WHERE YCO_RESID_ = :YCO_RESID_';
    objQryAux.ParamByName('YCO_RESID_').AsLargeInt := objConsultaCobranca.TabelaParametros.Id;
    objQryAux.Open;

    objResposta := TRespostaConsultaCobrancaV3ComSucesso(objConsultaCobranca.Resposta);

    if blnVerificarSeCobrancaPagaFoiCanceladaNaNuvem then
    begin
      if (objResposta.Status) then
        Exit;
    end;

    pAtualizaCampoStatus;
    pAtualizaCampoAtivaSim;
    pAtualizaCampoAtivaNao;
    objQryAux.Close;
  finally
    if Assigned(objQryAux) then
     FreeAndNil(objQryAux);
  end;
end;

function TYapayFacade.fGetAutIncCobrancaById(pIntId: int64): string;
var
  objQryAux : TDao.TQuery;
begin
  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT AUTOINCREM' + sLineBreak +
      '  FROM YAPCOB' + sLineBreak +
      ' WHERE YCO_RESID_ = :YCO_RESID_';
    objQryAux.ParamByName('YCO_RESID_').AsLargeInt := pIntId;
    objQryAux.Open;
    Result := objQryAux.Fields[0].AsString;
    objQryAux.Close;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;
end;

function TYapayFacade.fGravarDetalhesPagamentoCobranca(pObjTransacao: TCobrancaTransacao; objQryCobranca: TUniQuery): Boolean;
var
  i: integer;
  objListagemTransacoes: TListagemTransacoes;
begin
  Result := True;

  objListagemTransacoes := TListagemTransacoes.Create;
  try
    try
      objListagemTransacoes.TabelaParametros.Id := pObjTransacao.Id;
      objListagemTransacoes.Conexao := objConexao;
      if not objListagemTransacoes.Enviar then
        Exit(False);

      if not Assigned(objListagemTransacoes.Resposta) then
        Exit(False);

      if not Assigned(objListagemTransacoes.Resposta.Pagination) then
        Exit(False);

      if objListagemTransacoes.Resposta.Pagination.Count = 0 then
        Exit(False);

      for I := 0 to objListagemTransacoes.Resposta.Data.Count - 1 do
      begin
        if objListagemTransacoes.Resposta.Data.Items[i].Status.Id <> TStatusTransacao.Approved.Dados.Id then
          Continue;

        objQryCobranca.Edit;
        objQryCobranca.FieldByName('YCO_PGOORI').AsFloat := objListagemTransacoes.Resposta.Data.Items[i].Original_price;
        objQryCobranca.FieldByName('YCO_PGOTAX').AsFloat := objListagemTransacoes.Resposta.Data.Items[i].Tax;
        objQryCobranca.FieldByName('YCO_PGOSEL').AsFloat := objListagemTransacoes.Resposta.Data.Items[i].Seller_price;
        objQryCobranca.FieldByName('YCO_PGOPAY').AsFloat := objListagemTransacoes.Resposta.Data.Items[i].Payment_price;
        objQryCobranca.FieldByName('YCO_PGOINS').AsInteger := objListagemTransacoes.Resposta.Data.Items[i].Payment.Installments;
        objQryCobranca.FieldByName('YCO_PAYMID').AsInteger := objListagemTransacoes.Resposta.Data.Items[i].Payment.Payment_method_id;
        objQryCobranca.FieldByName('YCO_PGOJSO').AsString := objListagemTransacoes.JSONRetorno;
        objQryCobranca.Post;
      end;
    except
      Result := False;
    end;
  finally
    objListagemTransacoes.Free;

    if Assigned(objQryCobranca) then
      FreeAndNil(objQryCobranca);
  end;
end;

procedure TYapayFacade.pGravaTransacoesCobrancaConsultada;
var
  objQryAux : TDao.TQuery;
  objResposta: TRespostaConsultaCobrancaV3ComSucesso;
  objTransacao: TCobrancaTransacao;

  function fObjQryCobranca: TDao.TQuery;
  begin
    Result := TDao.TQuery.fFactory;
    Result.SQL.Text :=
      'SELECT YCO_RESID_,' + sLineBreak +
      '       YCO_RESPAG,' + sLineBreak +
      '       YCO_RESATV,' + sLineBreak +
      '       YCO_PGOORI,' + sLineBreak +
      '       YCO_PGOTAX,' + sLineBreak +
      '       YCO_PGOSEL,' + sLineBreak +
      '       YCO_PGOPAY,' + sLineBreak +
      '       YCO_PGOINS,' + sLineBreak +
      '       YCO_PGOJSO,' + sLineBreak +
      '       YCO_PAYMID' + sLineBreak +
      '  FROM YAPCOB' + sLineBreak +
      ' WHERE YCO_RESID_ = :YCO_RESID_';
    Result.ParamByName('YCO_RESID_').AsLargeInt := objResposta.Id;
    Result.Open;
  end;

  procedure pAtualizaStatusPagaCobranca;
  var
    objQryCobranca: TDao.TQuery;
  begin
    objQryCobranca := fObjQryCobranca;
    try
      case objTransacao.Status of
        TStatusTransacao.Approved:
        begin
          if CompareText(objQryCobranca.FieldByName('YCO_RESPAG').AsString, Sim.ToFlag) <> 0 then
          begin
            objQryCobranca.Edit;
            objQryCobranca.FieldByName('YCO_RESPAG').AsString := Sim.ToFlag;
            objQryCobranca.Post;
          end;
        end;
        TStatusTransacao.Canceled:
        begin
          if CompareText(objQryCobranca.FieldByName('YCO_RESATV').AsString, Nao.ToFlag) <> 0 then
          begin
            objQryCobranca.Edit;
            objQryCobranca.FieldByName('YCO_RESATV').AsString := Nao.ToFlag;
            objQryCobranca.Post;
          end;
        end
      end;
      objQryCobranca.Close;
    finally
      if Assigned(objQryCobranca) then
        FreeAndNil(objQryCobranca);
    end;
  end;

  function fGeraConteudoMensagem(pObjPedido: TPedido): string;
  begin
    Result :=
        IfThen(objTransacao.Status = Approved,
               'Pagamento ',
               'Cancelamento ') +
        'de Transação Yapay do Pedido ' +
        pObjPedido.strNumDoc + '-' +
        pObjPedido.strEspDoc + '-' +
        pObjPedido.strEmpDoc + sLineBreak + sLineBreak +
      '-------------------------------------------------------------------- ' + sLineBreak +
      '                         Dados Autcom                                ' + sLineBreak +
      '-------------------------------------------------------------------- ' + sLineBreak +
      'Pedido: ' + pObjPedido.strNumDoc + '-' + pObjPedido.strEspDoc + '-' + pObjPedido.strEmpDoc + sLineBreak +
      'Nome do Cliente: ' + pObjPedido.strCodCli + '-' + pObjPedido.strCliNom + sLineBreak + sLineBreak +
      '-------------------------------------------------------------------- ' + sLineBreak +
      '                         Dados Yapay                                 ' + sLineBreak +
      '-------------------------------------------------------------------- ' + sLineBreak +
      'Cobrança Id: ' + objConsultaCobranca.TabelaParametros.Id.ToString + sLineBreak +
      'Transação Id: ' + objTransacao.Id.ToString + sLineBreak +
      'Nome do Cliente (Conta Yapay): ' + objTransacao.Customer_name + sLineBreak +
      'Email (Conta Yapay): ' + objTransacao.Customer_email + sLineBreak +
      'Valor Transação: ' + FormatFloat('R$ 0.00#,##', objTransacao.Price) + sLineBreak +
      'Data Transação: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', objTransacao.Created_at);
  end;

  procedure pEnviaMensagem;
  var
    objPedido: TPedido;
    objMsgInterna: TMsgInterna;
    strAssunto: string;
  begin
    objPedido := TPedido.Create(objConsultaCobranca.TabelaParametros.Id);
    objMsgInterna := TMsgInterna.Create(Application.MainForm);
    try
      strAssunto :=
        IfThen(objTransacao.Status = Approved,
               'Pagamento ',
               'Cancelamento ') +
        'de Transação Yapay do Pedido ' +
        objPedido.strNumDoc + '-' +
        objPedido.strEspDoc + '-' +
        objPedido.strEmpDoc;

      objMsgInterna.fEnviaMensagem(
        strAssunto,
        fGeraConteudoMensagem(objPedido),
        fCfgSis('YAPOPE'),
        objPedido.strCodVen,
        'N',
        NullAsStringValue);
    finally
      if Assigned(objMsgInterna) then
        FreeAndNil(objMsgInterna);

      if Assigned(objPedido) then
        FreeAndNil(objPedido);
    end;
  end;

  function fPersisteDadosTransacao: Boolean;
  begin
    Result := True;
    try
      objQryAux.Close;
      objQryAux.ParamByName('YTR_TRAID_').AsLargeInt := objTransacao.Id;
      objQryAux.Open;

      if objQryAux.IsEmpty then
      begin
        objQryAux.Insert;
        objQryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('YAPTRA',VS_strCodEmp);
      end
      else
        objQryAux.Edit;

      objQryAux.FieldByName('YCO_SEQGER').AsString := fGetAutIncCobrancaById(objResposta.Id);
      objQryAux.FieldByName('YTR_TRARES').AsString := objTransacao.Resource;
      objQryAux.FieldByName('YTR_TRAID_').AsLargeInt := objTransacao.Id;
      objQryAux.FieldByName('YTR_CUSNAM').AsString := objTransacao.Customer_name;
      objQryAux.FieldByName('YTR_CUSEMA').AsString := objTransacao.Customer_email;
      objQryAux.FieldByName('YTR_TRAPRI').AsFloat := objTransacao.Price;
      objQryAux.FieldByName('YTR_STATAG').AsString := objTransacao.Status_tag;
      objQryAux.FieldByName('YTR_STANAM').AsString := objTransacao.Status_name;
      objQryAux.FieldByName('YTR_TRACRE').AsDateTime := objTransacao.Created_at;
      objQryAux.FieldByName('YTR_TRASID').AsLargeInt := objTransacao.Status.Dados.Id;
      objQryAux.Post;
    except
      Result := False;
    end;
  end;

begin
  objResposta := TRespostaConsultaCobrancaV3ComSucesso(objConsultaCobranca.Resposta);
  if objResposta.Transactions.Count = 0 then
    exit;

  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT *' + sLineBreak +
      '  FROM YAPTRA' + sLineBreak +
      ' WHERE YTR_TRAID_ = :YTR_TRAID_';

    for objTransacao in objResposta.Transactions do
    begin

      if blnVerificarSeCobrancaPagaFoiCanceladaNaNuvem then
      begin
        objQryAux.Close;
        objQryAux.ParamByName('YTR_TRAID_').AsLargeInt := objTransacao.Id;
        objQryAux.Open;

        if (objTransacao.Status <> TStatusTransacao.Canceled) and (objQryAux.FieldByName('YTR_TRASID').AsLargeInt = objTransacao.Status.Dados.Id) then
          Continue;
      end;

      if not fPersisteDadosTransacao then
        Exit;

      case objTransacao.Status of
        TStatusTransacao.Approved:
        begin
          if not fGravarDetalhesPagamentoCobranca(objTransacao, fObjQryCobranca) then
            Exit;

          if blnVerificarSeCobrancaPagaFoiCanceladaNaNuvem then
            Continue;

          if not fLancaAdiantamentoCliente(objTransacao) then
            Exit;

          pEnviaMensagem;
        end;
        TStatusTransacao.Canceled:
        begin
          pEnviaMensagem;
        end
      end;

      pAtualizaStatusPagaCobranca;
    end;

  finally
    if objQryAux.Active then
      objQryAux.Close;

    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;
end;

function TYapayFacade.fLancaAdiantamentoCliente(pObjTransacao: TCobrancaTransacao): Boolean;
var
  objParam: TAdiantamento.TParametroRealizarAdiantamentoClienteYapay;
  objPedido: TPedido;
  objFormasPagamento: TFormasPagamento;
begin
  objPedido := TPedido.Create(objConsultaCobranca.TabelaParametros.Id);
  objParam := TAdiantamento.TParametroRealizarAdiantamentoClienteYapay.Create;
  try
    objParam.strNumDoc := objPedido.strNumDoc;
    objParam.strEspDoc := objPedido.strEspDoc;
    objParam.strCodEmp := objPedido.strEmpDoc;
    objParam.ConsultaCobranca := objConsultaCobranca;
    objParam.Transacao := pObjTransacao;

    objParam.intQuantidadeParcelas := fCampoTabela('YCO_PGOINS', 'YAPCOB', ['YCO_RESID_'], [objConsultaCobranca.TabelaParametros.Id]);
    if objParam.intQuantidadeParcelas = 0 then
      objParam.intQuantidadeParcelas := 1;

    objFormasPagamento := TFormasPagamento.FindById(fCampoTabela('YCO_PAYMID', 'YAPCOB', ['YCO_RESID_'], [objConsultaCobranca.TabelaParametros.Id]));
    objParam.intPrazo := 0;
    case objFormasPagamento.Dados.TipoFormaPagamento of
      TransferenciasOnline:
      begin
        objParam.intPrazo := fCfgSis('YAPPRT');
      end;
      Boleto:
      begin
        objParam.intPrazo := fCfgSis('YAPPRB');
      end;
      Saldo:
      begin
        objParam.intPrazo := fCfgSis('YAPPRS');
      end;
      CartoesDeCredito:
      begin
        objParam.intPrazo := fCfgSis('YAPPRC');
      end;
    end;

    objParam.fltValorTaxa     := fCampoTabela('YCO_PGOTAX', 'YAPCOB', ['YCO_RESID_'], [objConsultaCobranca.TabelaParametros.Id]);
    objParam.fltValorOriginal := fCampoTabela('YCO_PGOORI', 'YAPCOB', ['YCO_RESID_'], [objConsultaCobranca.TabelaParametros.Id]);
    objParam.fltValorPago     := fCampoTabela('YCO_PGOSEL', 'YAPCOB', ['YCO_RESID_'], [objConsultaCobranca.TabelaParametros.Id]);

    objParam.strOrderNumber := TRespostaConsultaCobrancaV3ComSucesso(objConsultaCobranca.Resposta).Order_number;

    Result := TAdiantamento.fRealizarAdiantamentoClienteYapay(objParam);
  finally
    if Assigned(objPedido) then
      FreeAndNil(objPedido);

    if Assigned(objParam) then
      FreeAndNil(objParam);
  end;
end;

class function TYapayFacade.fEnviaCobrancasPendentes: Boolean;
var
  objQryAux : TDao.TQuery;
  objPedido : TPedido;
  blnRetorno: Boolean;
begin
  result := True;
  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT FATGOR.AUTOINCREM,' + sLineBreak +
      '       FATGOR.FGO_NUMDOC,' + sLineBreak +
      '       FATGOR.FGO_ESPDOC,' + sLineBreak +
      '       FATGOR.FGO_CODEMP,' + sLineBreak +
      '       FATGOR.FGO_VLRCON,' + sLineBreak +
      '       FATGOR.FGO_EMLCON,' + sLineBreak +
      '       FATGOR.FGO_CODCLI,' + sLineBreak +
      '       CADCLI.CLI_NOMCLI,' + sLineBreak +
      '       CADCLI.CLI_EMAIL_,' + sLineBreak +
      '       FATGOR.FGO_CODVEN' + sLineBreak +
      '  FROM FATGOR' + sLineBreak +
      '  JOIN YAPCOB' + sLineBreak +
      '    ON YAPCOB.FGO_SEQGER = FATGOR.AUTOINCREM' + sLineBreak +
      '  JOIN CADCLI' + sLineBreak +
      '    ON CADCLI.CLI_CODCLI = FATGOR.FGO_CODCLI' + sLineBreak +
      ' WHERE YAPCOB.YCO_RESID_ IS NULL' + sLineBreak +
      '   AND YAPCOB.YCO_RESATV = :YCO_RESATV' + sLineBreak +
      '   AND FATGOR.FGO_CODEMP = :FGO_CODEMP';
    objQryAux.ParamByName('YCO_RESATV').AsString := Sim.ToFlag;
    objQryAux.ParamByName('FGO_CODEMP').AsString := VS_strCodEmp;
    objQryAux.Open;
    objQryAux.First;
    while not objQryAux.Eof do
    begin
      objPedido := TPedido.Create;
      try
        objPedido.strAutIncFatGor := objQryAux.FieldByName('AUTOINCREM').AsString;
        objPedido.strCodCli := objQryAux.FieldByName('FGO_CODCLI').AsString;
        objPedido.strCliNom := objQryAux.FieldByName('CLI_NOMCLI').AsString;
        objPedido.strCliEma := objQryAux.FieldByName('CLI_EMAIL_').AsString;
        objPedido.strNumDoc := objQryAux.FieldByName('FGO_NUMDOC').AsString;
        objPedido.strEspDoc := objQryAux.FieldByName('FGO_ESPDOC').AsString;
        objPedido.strEmpDoc := objQryAux.FieldByName('FGO_CODEMP').AsString;
        objPedido.fltTotGer := objQryAux.FieldByName('FGO_VLRCON').AsFloat;
        objPedido.strCodVen := objQryAux.FieldByName('FGO_CODVEN').AsString;
        try
          blnRetorno := TYapayFacade.fEnviaCobranca(objPedido, false, false);
        except
          blnRetorno := False;
        end;
        if (not blnRetorno) and (result) then
          result := blnRetorno;
      finally
        if Assigned(objPedido) then
          FreeAndNil(objPedido);
      end;
      objQryAux.Next;
      pZerarTentativasLock(Format(TYapayFacade.objCfgMonitor.strID_MONITOR, [VS_strCodEmp]));
    end;
    objQryAux.Close;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;
end;

constructor TYapayFacade.TPedido.Create(const pIntAutoIncCobranca: int64);
var
  objQryAux: TDao.TQuery;
begin
  inherited Create;
  objQryAux := TYapayFacade.TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT FATGOR.AUTOINCREM,' + sLineBreak +
      '       FATGOR.FGO_NUMDOC,' + sLineBreak +
      '       FATGOR.FGO_ESPDOC,' + sLineBreak +
      '       FATGOR.FGO_CODEMP,' + sLineBreak +
      '       FATGOR.FGO_VLRCON,' + sLineBreak +
      '       FATGOR.FGO_EMLCON,' + sLineBreak +
      '       FATGOR.FGO_CODCLI,' + sLineBreak +
      '       CADCLI.CLI_NOMCLI,' + sLineBreak +
      '       CADCLI.CLI_EMAIL_,' + sLineBreak +
      '       FATGOR.FGO_CODVEN' + sLineBreak +
      '  FROM FATGOR' + sLineBreak +
      '  JOIN YAPCOB' + sLineBreak +
      '    ON YAPCOB.FGO_SEQGER = FATGOR.AUTOINCREM' + sLineBreak +
      '  JOIN CADCLI' + sLineBreak +
      '    ON CADCLI.CLI_CODCLI = FATGOR.FGO_CODCLI' + sLineBreak +
       'WHERE YAPCOB.YCO_RESID_ = :YCO_RESID_';
    objQryAux.ParamByName('YCO_RESID_').AsInteger := pIntAutoIncCobranca;
    objQryAux.Open;
    Self.strAutIncFatGor := objQryAux.FieldByName('AUTOINCREM').AsString;
    Self.strCodCli := objQryAux.FieldByName('FGO_CODCLI').AsString;
    Self.strCliNom := objQryAux.FieldByName('CLI_NOMCLI').AsString;
    Self.strCliEma := objQryAux.FieldByName('CLI_EMAIL_').AsString;
    Self.strNumDoc := objQryAux.FieldByName('FGO_NUMDOC').AsString;
    Self.strEspDoc := objQryAux.FieldByName('FGO_ESPDOC').AsString;
    Self.strEmpDoc := objQryAux.FieldByName('FGO_CODEMP').AsString;
    Self.fltTotGer := objQryAux.FieldByName('FGO_VLRCON').AsFloat;
    Self.strCodVen := objQryAux.FieldByName('FGO_CODVEN').AsString;
    objQryAux.Close;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;
end;

class function TYapayFacade.TDao.TQuery.fFactory: TDao.TQuery;
begin
  result := TDao.TQuery(fCriaQuery);
  result.Options.SetEmptyStrToNull := True;
  result.Options.TrimVarChar := True;
end;

class function TYapayFacade.fExecutaRotinasMonitor: Boolean;
begin
  Result := TMonitorLib.fExecuteConsultaCobrancas;
  if TMonitorLib.fExecuteEnviaCobrancasPendentes and Result then
    Result := True;
end;

class function TYapayFacade.fVerificaExistenciaRestDLL: Boolean;
begin
  if not (fCfgSis('YAPHAB',varBoolean)) then
    exit(True);

  if not FileExists(sYAPAY_API_REST_DLL) then
  begin
    fMensagem('Yapay', Format(sYAPAY_API_REST_MENSAGEM_ERRO_DLL_NAO_ENCONTRADA, [sYAPAY_API_REST_DLL]),['&OK']);
    exit(False);
  end;

  Result := True;
end;

class function TYapayFacade.TCfgMonitor.GetExeName: string;
begin
  result := ExtractFileName(application.ExeName);
end;

class function TYapayFacade.TMonitorLib.fExecuteConsultaCobrancas: Boolean;
begin
  Result := True;
  try
    TYapayFacade.fConsultaCobrancas(False);
  except
    on E: Exception do
    begin
      Result := False;
      GravaLog('fConsultaCobrancas', E.Message);
    end;
  end;
end;

class function TYapayFacade.TMonitorLib.fExecuteEnviaCobrancasPendentes: Boolean;
begin
  Result := True;
  try
    TYapayFacade.fEnviaCobrancasPendentes;
  except
    on E: Exception do
    begin
      Result := False;
      GravaLog('fEnviaCobrancasPendentes', E.Message);
    end;
  end;
end;

class procedure TYapayFacade.TMonitorLib.GravaLog(const pstrProcName, pStrMensagem: string);
//var
//  strCaminhoArquivo: string;
//  stlConteudoLog: TStringList;
begin
//  strCaminhoArquivo := ExtractFileDir(Application.exename) + '\Yapay.Api.Rest.Log';
//  if not DirectoryExists(strCaminhoArquivo) then
//    ForceDirectories(strCaminhoArquivo);
//
//  strCaminhoArquivo := strCaminhoArquivo + '\LogError.' + pstrProcName + '.' + FormatDateTime('yyyymmddhhnnsszzz', Date + fTime()) + '.log';
//
//  stlConteudoLog := TStringList.Create;
//  try
//    if FileExists(strCaminhoArquivo) then
//      stlConteudoLog.LoadFromFile(strCaminhoArquivo);
//    stlConteudoLog.Add(pStrMensagem);
//
//    stlConteudoLog.SaveToFile(strCaminhoArquivo);
//  finally
//    if Assigned(stlConteudoLog) then
//      stlConteudoLog.Free;
//  end;
end;

{ TYapayFacade.TcxCheckComboBox }

function TYapayFacade.TcxCheckComboBox.GetValue: string;
var
  objStringList: TStringList;
  i: integer;
begin
  Result := String.Empty;
  objStringList := TStringList.Create;
  try
    objStringList.Delimiter := '_';
    objStringList.Clear;

    for I := 0 to Self.Properties.Items.Count - 1 do
    begin
      if Self.States[i] = cbsChecked then
        objStringList.Add(FormatFloat('000', Self.Properties.Items[i].Tag));
    end;

    if objStringList.Count = 0 then
      Exit(String.Empty);

    Result := objStringList.DelimitedText;
  finally
    objStringList.Free;
  end;
end;

procedure TYapayFacade.TcxCheckComboBox.SetValue(const Value: string);
var
  objStringList: TStringList;
  objItem: TcxCheckComboBoxItem;
  i, j: integer;
begin
  Self.ClearSelection;

  if Value.IsEmpty then
    Exit;

  objStringList := TStringList.Create;
  try
    objStringList.Delimiter := '_';
    objStringList.DelimitedText := Value;
    for I := 0 to objStringList.Count - 1 do
    begin
      for j := 0 to Self.Properties.Items.Count - 1 do
      begin
        objItem := Self.Properties.Items[j];
        if objStringList[i] = FormatFloat('000', objItem.Tag) then
          Self.States[j] := cbsChecked;
      end;
    end;
  finally
    objStringList.Free;
  end;
end;

procedure TYapayFacade.TcxCheckComboBox.PopulaFormasPagamento;
var
  i: integer;
  objItem: TcxCheckComboBoxItem;
begin
  Self.Properties.Items.BeginUpdate;
  Self.Properties.Items.Clear;
  for I := ord(TFormasPagamento(low(TFormasPagamento))) to ord(TFormasPagamento(high(TFormasPagamento))) do
  begin
    objItem := Self.Properties.Items.Add;
    objItem.Description := TFormasPagamento(i).Dados.Descricao;
    objItem.Enabled := True;
    objItem.ShortDescription := TFormasPagamento(i).Dados.Descricao;
    objItem.Tag := TFormasPagamento(i).Dados.Id;
  end;
  Self.Properties.Items.EndUpdate;
end;

function TYapayFacade.TPedido.GetFormasDePagamentoDisponiveis: TListFormasDePagamento;
var
  objQryAux : TDao.TQuery;
  objStringList: TStringList;
  i: integer;
  objFormaPagamento: TFormasPagamento;
const
  objNENHUMA_FORMA_PAGAMENTO_SELECIONADA = [];
begin
  Result := objNENHUMA_FORMA_PAGAMENTO_SELECIONADA;
  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT CND_YAPTRA,' + sLineBreak +
      '       CND_YAPDIS' + sLineBreak +
      '  FROM FATGOR' + sLineBreak +
      '  JOIN CADCND' + sLineBreak +
      '    ON CND_CODIGO = FGO_CODCND' + sLineBreak +
      ' WHERE FATGOR.FGO_NUMDOC = :FGO_NUMDOC' + sLineBreak +
      '   AND FATGOR.FGO_ESPDOC = :FGO_ESPDOC' + sLineBreak +
      '   AND FATGOR.FGO_CODEMP = :FGO_CODEMP';
    objQryAux.ParamByName('FGO_NUMDOC').AsString := strNumDoc;
    objQryAux.ParamByName('FGO_ESPDOC').AsString := strEspDoc;
    objQryAux.ParamByName('FGO_CODEMP').AsString := strEmpDoc;
    objQryAux.Open;

    if objQryAux.FieldByName('CND_YAPTRA').AsString <> Sim.ToFlag then
      Exit(objNENHUMA_FORMA_PAGAMENTO_SELECIONADA);

    if objQryAux.FieldByName('CND_YAPDIS').AsString.IsEmpty then
      Exit(objNENHUMA_FORMA_PAGAMENTO_SELECIONADA);

    objStringList := TStringList.Create;
    try
      objStringList.Delimiter := '_';
      objStringList.DelimitedText := objQryAux.FieldByName('CND_YAPDIS').AsString;
      for I := 0 to objStringList.Count - 1 do
      begin
        objFormaPagamento := TFormasPagamento.FindById(StrToIntDef(objStringList[i],-1));
        if objFormaPagamento = TFormasPagamento.Desconhecido then
          Continue;
        Result := Result + [objFormaPagamento];
      end;
    finally
      objStringList.Free;
    end;
    objQryAux.Close;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;
end;

function TYapayFacade.TPedido.GetQuantidadeParcelas: integer;
var
  objQryAux : TDao.TQuery;
const
  intNENHUMA_PARCELA = 0;
  intPARCELA_UNICA = 1;
begin
  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT CND_YAPTRA,' + sLineBreak +
      '       CND_YAPPAR' + sLineBreak +
      '  FROM FATGOR' + sLineBreak +
      '  JOIN CADCND' + sLineBreak +
      '    ON CND_CODIGO = FGO_CODCND' + sLineBreak +
      ' WHERE FATGOR.FGO_NUMDOC = :FGO_NUMDOC' + sLineBreak +
      '   AND FATGOR.FGO_ESPDOC = :FGO_ESPDOC' + sLineBreak +
      '   AND FATGOR.FGO_CODEMP = :FGO_CODEMP';
    objQryAux.ParamByName('FGO_NUMDOC').AsString := strNumDoc;
    objQryAux.ParamByName('FGO_ESPDOC').AsString := strEspDoc;
    objQryAux.ParamByName('FGO_CODEMP').AsString := strEmpDoc;
    objQryAux.Open;

    if objQryAux.FieldByName('CND_YAPTRA').AsString <> Sim.ToFlag then
      Exit(intNENHUMA_PARCELA);

    Result := objQryAux.FieldByName('CND_YAPPAR').AsInteger;

    if Result = intNENHUMA_PARCELA then
      Result := intPARCELA_UNICA;

    objQryAux.Close;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;
end;

class function TYapayFacade.fAdiantamentoVinculadoCobrancaParaEstorno(pStrAutoIncrem: string): boolean;
var
  objQryAux : TDao.TQuery;
begin
  objQryAux := TDao.TQuery.fFactory;
  try
    objQryAux.SQL.Text :=
      'SELECT 1' + sLineBreak +
      '  FROM ADTCLI' + sLineBreak +
      '  JOIN FATGOR' + sLineBreak +
      '    ON FGO_NUMDOC = ADT_NUMDOC' + sLineBreak +
      '   AND FGO_ESPDOC = ADT_ESPDOC' + sLineBreak +
      '   AND FGO_CODEMP = ADT_CODEMP' + sLineBreak +
      '   AND FGO_CODCLI = ADT_CODCLI' + sLineBreak +
      '  JOIN YAPCOB' + sLineBreak +
      '    ON YAPCOB.FGO_SEQGER = FATGOR.AUTOINCREM' + sLineBreak +
      ' WHERE ADTCLI.AUTOINCREM = :AUTOINCREM' + sLineBreak +
      '   AND ADTCLI.ADT_DESCRI LIKE ' + QuotedStr('%YAPAY%') + sLineBreak +
      '   AND YAPCOB.YCO_RESATV = :YCO_RESATV' + sLineBreak +
      '   AND YAPCOB.YCO_RESPAG = :YCO_RESPAG';

    objQryAux.ParamByName('AUTOINCREM').AsString := pStrAutoIncrem;
    objQryAux.ParamByName('YCO_RESATV').AsString := Nao.ToFlag;
    objQryAux.ParamByName('YCO_RESPAG').AsString := Sim.ToFlag;
    objQryAux.Open;

    Result := not objQryAux.IsEmpty;

    objQryAux.Close;
  finally
    if Assigned(objQryAux) then
      FreeAndNil(objQryAux);
  end;

end;

end.
