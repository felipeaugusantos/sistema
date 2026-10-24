unit untReformaHostAdapter;

{*************************************************************************}
{* ADAPTER DO PLUGIN libReformaPrecos SOBRE O CADASTRO DE PRODUTOS DO    *}
{* 74.111. O PLUGIN SO CONHECE AS INTERFACES DE Reforma.Contrato.Host;   *}
{* CADA UMA CHAMA AQUI O MESMO CALCULO QUE A ABA 1 JA USA (cpcParams,    *}
{* fCalculaPrecoVenda, fCalculaCustoReal), SEM REPLICAR FORMULA.         *}
{*************************************************************************}

interface

uses
  Reforma.Contrato.Tipos, Reforma.Contrato.Gravacao, Reforma.Contrato.Host, Reforma.Contrato.Convert, untCadProdutos;

type
  TReformaHostAdapter = class(TInterfacedObject, IReformaHost, IReformaCalculoConvert)
  private
    FfrmProdutos: TfrmCadProdutos;
    FobjProduto: IDadosProduto;
    FobjCusto: ICalculoCustoHost;
    FobjMargem: ICalculoMargemHost;
    FobjGravacao: IReformaGravacao;
  public
    constructor Create(Const AfrmProdutos: TfrmCadProdutos);

    function Configuracao: TConfiguracaoReforma;
    function ConfiguracaoTexto(Const AstrChave: String): String;
    function ConfiguracaoBooleana(Const AstrChave: String): Boolean;
    function CotacaoDolarVenda: Double;
    function CodigoEmpresa: String;
    function Produto: IDadosProduto;
    function CalculoCusto: ICalculoCustoHost;
    function CalculoMargem: ICalculoMargemHost;
    function AbrirConsulta(Const AstrSql: String): IReformaConsulta;
    function TextoParaNumero(Const AstrTexto: String): Double;
    procedure Mensagem(Const AstrTitulo, AstrTexto: String);
    procedure FocarControle(Const AintHandle: NativeUInt);
    function GeometriaControle(Const AstrChave: String; out AintEsquerda, AintTopo, AintLargura, AintAltura: Integer): Boolean;
    function EstiloVisual: String;
    function CorRotulo(Const AstrChave: String; out AintCor: Integer): Boolean;
    function Gravacao: IReformaGravacao;
    function AlvosReplicacao(Const AstrCodIte: String): TAlvosReplicacao;
    function ProdutoNaEmpresa(Const AstrCodEmp, AstrCodIte: String): IDadosProduto;
    function Acesso(Const AstrDireito: String): Boolean;

    // IReformaCalculoConvert (contrato 11): aba 4 "Calculo Convert", pelo mesmo calculo do Convert (untReformaConvertHost).
    function Operador: String;
    function DecimaisUnitarios: Integer;
    function CalcularItemBase(Const AOpcao: TOpcaoConversao; Const ArecEntrada: TEntradaConversao;
      Const AarrBase: TArray<TValorCampo>; out ArecValores: TValoresConversao): TResultadoGravacao;
  end;

implementation

uses
  SysUtils, Classes, Controls, Variants, DB, Uni, Vcl.StdCtrls, Vcl.Themes, untConstantes, untFuncoesSimples,
  untFatorPreco, untParCalculaPrecoCusto, untReformaGravacaoHost, untReformaConvertHost;

// Foco em janela da DLL: o controle nao e componente do host, so handle. O pre-commit veda o metodo
// SetFocus chamado com ponto, entao a chamada vai direto na API.
function pFocarJanela(AhWnd: NativeUInt): NativeUInt; stdcall; external 'user32' name 'SetFocus';

type
  TReformaProduto = class(TInterfacedObject, IDadosProduto)
  private
    FfrmProdutos: TfrmCadProdutos;
    function fCampo(Const AstrCampo: String): TField;
  public
    constructor Create(Const AfrmProdutos: TfrmCadProdutos);

    function CodigoItem: String;
    function Estado: TEstadoCadastro;
    function ValorNumerico(Const AstrCampo: String): Double;
    function ValorTexto(Const AstrCampo: String): String;
    function FormatoExibicao(Const AstrCampo: String): String;
    function RotuloCampo(Const AstrCampo: String): String;
    function FonteDados: TDataSource;
    function ValidarCampo(Const AstrCampo: String): Boolean;
  end;

  TReformaCusto = class(TInterfacedObject, ICalculoCustoHost)
  private
    FfrmProdutos: TfrmCadProdutos;
  public
    constructor Create(Const AfrmProdutos: TfrmCadProdutos);

    function PrecoCompraLiquido(Const AEntrada: TCustoEntrada): Double;
    function PrecoCusto(Const AEntrada: TCustoEntrada): Double;
    function CustoReal(Const AEntrada: TCustoRealEntrada): Double;
  end;

  TReformaMargem = class(TInterfacedObject, ICalculoMargemHost)
  private
    FfrmProdutos: TfrmCadProdutos;
  public
    constructor Create(Const AfrmProdutos: TfrmCadProdutos);

    function CalcularPrecoVenda(Const AOpcao: TOpcaoCalculo; Const AEntrada: TVendaEntrada): Double;
    function TabelaComFatorAtivo(Const AintTabelaPreco: Integer): Boolean;
    function MarkupParaMargem(Const AfltMarkup: Double): Double;
    function MargemNaEmpresa(Const AstrCodEmp, AstrCodIte: String; Const AEntrada: TVendaEntrada): Double;
  end;

  // Produto ja gravado em outra empresa (replicacao da REFPRE): o ITEGER dela, lido na transacao da gravacao. So
  // valores; o resto de IDadosProduto e do produto em edicao e aqui nao se aplica.
  TReformaProdutoEmpresa = class(TInterfacedObject, IDadosProduto)
  private
    FqryProduto: TUniQuery;
  public
    constructor Create(Const AstrCodEmp, AstrCodIte: String);
    destructor Destroy; override;
    function fExiste: Boolean;

    function CodigoItem: String;
    function Estado: TEstadoCadastro;
    function ValorNumerico(Const AstrCampo: String): Double;
    function ValorTexto(Const AstrCampo: String): String;
    function FormatoExibicao(Const AstrCampo: String): String;
    function RotuloCampo(Const AstrCampo: String): String;
    function FonteDados: TDataSource;
    function ValidarCampo(Const AstrCampo: String): Boolean;
  end;


{ TReformaHostAdapter }

constructor TReformaHostAdapter.Create(Const AfrmProdutos: TfrmCadProdutos);
begin
  inherited Create;
  FfrmProdutos := AfrmProdutos;
  FobjProduto := TReformaProduto.Create(AfrmProdutos);
  FobjCusto := TReformaCusto.Create(AfrmProdutos);
  FobjMargem := TReformaMargem.Create(AfrmProdutos);
  FobjGravacao := TReformaGravacao.Create;
end;

function TReformaHostAdapter.Configuracao: TConfiguracaoReforma;
  Var
    intTabela: Integer;
begin
  FillChar(Result, SizeOf(Result), 0);

  Result.DecimaisUnitarios := FfrmProdutos.ReformaDecimais;
  Result.FormulaCusto := StrToIntDef(VarToStr(fCfgSis('FRMCUS')), 0);
  Result.MargemMarkup := StrToIntDef(FfrmProdutos.ReformaMargemMarkup, 0);
  Result.UsaSuframa := fCfgSis('SUFRAM', varBoolean);
  Result.ExibeComissao := FfrmProdutos.fReformaExibeComissao;
  Result.ReduzImpostoFederal := FfrmProdutos.ReformaReduzImpostoFederal;
  Result.RecalculaPrecoPelaMargem := FfrmProdutos.ReformaVendaMargem = 1;
  Result.PrecosDaMatriz := FfrmProdutos.ReformaPrecosDaMatriz;

  // VS_strTabPrc ja vem completado com 'N' ate 7 posicoes (untFuncoesSimples).
  For intTabela := 1 To QUANTIDADE_TABELAS_PRECO Do
    Result.TabelaAtiva[intTabela] := (intTabela <= Length(VS_strTabPrc)) And (VS_strTabPrc[intTabela] = 'S');
end;

function TReformaHostAdapter.ConfiguracaoTexto(Const AstrChave: String): String;
begin
  Result := VarToStr(fCfgSis(AstrChave));
end;

function TReformaHostAdapter.ConfiguracaoBooleana(Const AstrChave: String): Boolean;
begin
  Result := fCfgSis(AstrChave, varBoolean);
end;

function TReformaHostAdapter.CotacaoDolarVenda: Double;
begin
  Result := fGetUltimaCotacaoDolarVenda;
end;

function TReformaHostAdapter.CodigoEmpresa: String;
begin
  Result := VS_strCodEmp;
end;

function TReformaHostAdapter.Produto: IDadosProduto;
begin
  Result := FobjProduto;
end;

function TReformaHostAdapter.CalculoCusto: ICalculoCustoHost;
begin
  Result := FobjCusto;
end;

function TReformaHostAdapter.CalculoMargem: ICalculoMargemHost;
begin
  Result := FobjMargem;
end;

function TReformaHostAdapter.AbrirConsulta(Const AstrSql: String): IReformaConsulta;
begin
  Result := TReformaConsulta.Create(AstrSql);
end;

function TReformaHostAdapter.TextoParaNumero(Const AstrTexto: String): Double;
begin
  Result := fStrToFloat(AstrTexto);
end;

procedure TReformaHostAdapter.Mensagem(Const AstrTitulo, AstrTexto: String);
begin
  fMensagem(AstrTitulo, AstrTexto, ['&Ok']);
end;

procedure TReformaHostAdapter.FocarControle(Const AintHandle: NativeUInt);
begin
  pFocarJanela(AintHandle);
end;

function TReformaHostAdapter.GeometriaControle(Const AstrChave: String; out AintEsquerda, AintTopo, AintLargura, AintAltura: Integer): Boolean;
begin
  // As abas 2 e 3 (DLL) se posicionam como a aba 1: o layout dela e lido do cadastro, nao copiado na DLL.
  Result := FfrmProdutos.fReformaGeometriaControle(AstrChave, AintEsquerda, AintTopo, AintLargura, AintAltura);
end;

function TReformaHostAdapter.EstiloVisual: String;
begin
  // Mesma condicao do TfrmPai.FormActivate para ajustar o tema do cadastro: a DLL ativa o mesmo estilo.
  Result := '';

  If (Not blnUsuarioLogadoUtilizaModoClassico) And (TStyleManager.ActiveStyle.Name = AUTCOM_STYLE_NAME) Then
    Result := TStyleManager.ActiveStyle.Name;
end;

function TReformaHostAdapter.CorRotulo(Const AstrChave: String; out AintCor: Integer): Boolean;
begin
  // pVerificaMargemGrupo e o FormShow pintam alguns titulos da aba 1; a aba 3 (DLL) mostra a mesma cor.
  Result := FfrmProdutos.fReformaCorRotulo(AstrChave, AintCor);
end;

function TReformaHostAdapter.Gravacao: IReformaGravacao;
begin
  Result := FobjGravacao;
end;

function TReformaHostAdapter.AlvosReplicacao(Const AstrCodIte: String): TAlvosReplicacao;
begin
  Result := FfrmProdutos.fReformaAlvosReplicacao(AstrCodIte);
end;

// Nil quando a empresa nao tem o item.
function TReformaHostAdapter.Operador: String;
begin
  Result := strLoginUsuarioLogado;
end;

function TReformaHostAdapter.DecimaisUnitarios: Integer;
begin
  Result := fReformaDecimaisConvert;
end;

// Nao le a tela: os campos dela vem da DLL em AarrBase (aba 3 em memoria).
function TReformaHostAdapter.CalcularItemBase(Const AOpcao: TOpcaoConversao; Const ArecEntrada: TEntradaConversao;
  Const AarrBase: TArray<TValorCampo>; out ArecValores: TValoresConversao): TResultadoGravacao;
begin
  Result := fReformaCalcularItemBase(AOpcao, ArecEntrada, AarrBase, ArecValores);
end;

// Contrato 13: esta versao nao tem os direitos da aba de precos que o plugin consulta (EDTCUS so existe nos 150.x) e a
// aba 1 daqui nao trava nada por eles: tudo liberado, como ela.
function TReformaHostAdapter.Acesso(Const AstrDireito: String): Boolean;
begin
  Result := True;
end;

function TReformaHostAdapter.ProdutoNaEmpresa(Const AstrCodEmp, AstrCodIte: String): IDadosProduto;
  Var
    objProduto: TReformaProdutoEmpresa;
begin
  objProduto := TReformaProdutoEmpresa.Create(AstrCodEmp, AstrCodIte);
  Try
    If objProduto.fExiste Then
    Begin
      Result := objProduto;
      // A interface passa a ser a dona do objeto.
      objProduto := Nil;
    End
    Else
      Result := Nil;
  Finally
    objProduto.Free;
  End;
end;

{ TReformaProduto }

constructor TReformaProduto.Create(Const AfrmProdutos: TfrmCadProdutos);
begin
  inherited Create;
  FfrmProdutos := AfrmProdutos;
end;

function TReformaProduto.fCampo(Const AstrCampo: String): TField;
begin
  Result := FfrmProdutos.fReformaCampo(AstrCampo);
end;

function TReformaProduto.CodigoItem: String;
begin
  Result := FfrmProdutos.fReformaCodigoItem;
end;

function TReformaProduto.Estado: TEstadoCadastro;
begin
  Result := ecConsulta;

  If FfrmProdutos.fReformaEstadoCadastro = dsInsert Then
    Result := ecInclusao
  Else If FfrmProdutos.fReformaEstadoCadastro = dsEdit Then
    Result := ecAlteracao;
end;

function TReformaProduto.ValorNumerico(Const AstrCampo: String): Double;
  Var
    fldCampo: TField;
begin
  Result := 0;

  fldCampo := fCampo(AstrCampo);
  If Assigned(fldCampo) And Not fldCampo.IsNull Then
    Result := fldCampo.AsFloat;
end;

function TReformaProduto.ValorTexto(Const AstrCampo: String): String;
  Var
    fldCampo: TField;
begin
  Result := '';

  fldCampo := fCampo(AstrCampo);
  If Assigned(fldCampo) Then
    Result := fldCampo.AsString;
end;

function TReformaProduto.FormatoExibicao(Const AstrCampo: String): String;
  Var
    fldCampo: TField;
begin
  Result := '';

  fldCampo := fCampo(AstrCampo);
  If Assigned(fldCampo) And (fldCampo Is TNumericField) Then
    Result := TNumericField(fldCampo).DisplayFormat;
end;

function TReformaProduto.RotuloCampo(Const AstrCampo: String): String;
  Var
    fldCampo: TField;
begin
  Result := '';

  fldCampo := fCampo(AstrCampo);
  If Assigned(fldCampo) Then
    Result := fldCampo.DisplayLabel;
end;

function TReformaProduto.FonteDados: TDataSource;
begin
  Result := FfrmProdutos.fReformaFonteDados;
end;

function TReformaProduto.ValidarCampo(Const AstrCampo: String): Boolean;
begin
  Result := FfrmProdutos.fReformaValidarCampo(AstrCampo);
end;

{ TReformaCusto }

constructor TReformaCusto.Create(Const AfrmProdutos: TfrmCadProdutos);
begin
  inherited Create;
  FfrmProdutos := AfrmProdutos;
end;

function TReformaCusto.PrecoCompraLiquido(Const AEntrada: TCustoEntrada): Double;
begin
  Result := untFuncoesSimples.fCalculaPrecoCompraLiq(AEntrada.PrecoCompra,
                                                     AEntrada.Descontos[1],
                                                     AEntrada.Descontos[2],
                                                     AEntrada.Descontos[3],
                                                     AEntrada.Descontos[4],
                                                     AEntrada.Descontos[5],
                                                     AEntrada.Descontos[6],
                                                     FfrmProdutos.ReformaDecimais,
                                                     AEntrada.ConverterMoeda);
end;

function TReformaCusto.PrecoCusto(Const AEntrada: TCustoEntrada): Double;
  Var
    blnSuframa: Boolean;
begin
  blnSuframa := fCfgSis('SUFRAM', varBoolean) And (fCfgSis('FRMCUS', varString) = '4');

  // Mesmo objeto que a aba 1 usa: todos os campos sao reatribuidos a cada calculo.
  With FfrmProdutos.ReformaCalculoCusto Do
  Begin
    curPreCom := AEntrada.PrecoCompra;
    curDesF01 := AEntrada.Descontos[1];
    curDesF02 := AEntrada.Descontos[2];
    curDesF03 := AEntrada.Descontos[3];
    curDesF04 := AEntrada.Descontos[4];
    curDesF05 := AEntrada.Descontos[5];
    curDesF06 := AEntrada.Descontos[6];
    curICMSEnt := AEntrada.IcmsEntrada;
    curIPIEnt := AEntrada.IpiEntrada;
    curFrete := AEntrada.FreteEntrada;
    curAcrFin := AEntrada.AcrescimoFinanceiro;
    curSubsti := AEntrada.Substituicao;
    curValFre := AEntrada.ValorFrete;
    curDesAdb := AEntrada.DescontoAdicional;
    curSubFed := AEntrada.SubFederal;

    If blnSuframa Then
    Begin
      curTCIFCu := AEntrada.SuframaTcif;
      curTSCust := AEntrada.SuframaTs;
      curDePiCo := AEntrada.SuframaDescontoPisCofins;
      curDeICMS := AEntrada.SuframaDescontoIcms;
      curFatReg := AEntrada.SuframaFatorRegional;
    End
    Else
    Begin
      curTCIFCu := 0;
      curTSCust := 0;
      curDePiCo := 0;
      curDeICMS := 0;
      curFatReg := 0;
    End;

    Result := fCalculaPrecoCusto(AEntrada.ConverterMoeda);
  End;
end;

function TReformaCusto.CustoReal(Const AEntrada: TCustoRealEntrada): Double;
begin
  // Markup 4 mostra o IVA no lugar do custo real (fIVAMod4 da aba 1).
  If FfrmProdutos.ReformaMargemMarkup = '4' Then
    Result := FfrmProdutos.fReformaIVAMod4
  Else
    Result := untFuncoesSimples.fCalculaCustoReal(AEntrada.PrecoCusto,
                                                  AEntrada.IcmsSaida,
                                                  AEntrada.ImpostoFederal,
                                                  AEntrada.DespesaOperacional,
                                                  AEntrada.OutrosValores);
end;

{ TReformaMargem }

constructor TReformaMargem.Create(Const AfrmProdutos: TfrmCadProdutos);
begin
  inherited Create;
  FfrmProdutos := AfrmProdutos;
end;

function TReformaMargem.CalcularPrecoVenda(Const AOpcao: TOpcaoCalculo; Const AEntrada: TVendaEntrada): Double;
  Var
    blnST: Boolean;
    fltIcmsSTParteVenda: Double;
    strCodAbr: String;
begin
  strCodAbr := FfrmProdutos.fReformaCodigoAbr;

  fltIcmsSTParteVenda := untFuncoesSimples.fGetIcmsSTParteVenda(blnST, strCodAbr,
                                                                AEntrada.PrecoCompraLiquido,
                                                                AEntrada.IpiEntrada,
                                                                AEntrada.IcmsSaida,
                                                                FfrmProdutos.ReformaMargemMarkup,
                                                                FfrmProdutos.ReformaEstadoEmpresa);

  // Opcao do host: 1 = preco de venda, 2 = margem.
  Result := untFuncoesSimples.fCalculaPrecoVenda(Ord(AOpcao) + 1,
                                                 AEntrada.PrecoCusto + AEntrada.OutrosValores,
                                                 AEntrada.PrecoVenda,
                                                 AEntrada.MargemBruta,
                                                 AEntrada.IcmsSaida,
                                                 AEntrada.ImpostoFederal,
                                                 AEntrada.DespesaOperacional,
                                                 AEntrada.Comissao,
                                                 '',
                                                 '',
                                                 -1,
                                                 fltIcmsSTParteVenda,
                                                 blnST);
end;

function TReformaMargem.TabelaComFatorAtivo(Const AintTabelaPreco: Integer): Boolean;
begin
  Result := (AintTabelaPreco >= 2) And FfrmProdutos.ReformaUsaFatorPreco And
            Assigned(FfrmProdutos.ReformaFatorPreco) And
            FfrmProdutos.ReformaFatorPreco.fTabelaAtiva(AintTabelaPreco);
end;

function TReformaMargem.MarkupParaMargem(Const AfltMarkup: Double): Double;
begin
  Result := untFuncoesSimples.fMarkupToMargem(AfltMarkup);
end;

// Mesma conta de CalcularPrecoVenda com as configuracoes de outra empresa, como o host recalcula as filiais com
// CFG_INFMAT: MARMKP, PCMPRO e DECUNI dela, e o ICMS-ST pela ABF do item nela (CFG_TIPABF) e pelo estado dela.
function TReformaMargem.MargemNaEmpresa(Const AstrCodEmp, AstrCodIte: String; Const AEntrada: TVendaEntrada): Double;
  Var
    qryEmpresa: TUniQuery;
    blnST: Boolean;
    fltIcmsSTParteVenda: Double;
    strMarMkp,
    strEstado,
    strCodAbf: String;
begin
  strMarMkp := VarToStr(fCfgSis('MARMKP', varString, AstrCodEmp));

  qryEmpresa := fCriaQuery(nil);
  Try
    qryEmpresa.SQL.Text := 'SELECT CID_ESTADO, CADITE.ITE_CODABF AS ABF_CADITE, ITEGER.ITE_CODABF AS ABF_ITEGER ' +
                           '  FROM CADEMP ' +
                           '  LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ' +
                           '  LEFT JOIN ITEGER ON ITEGER.ITE_CODEMP = EMP_CODEMP AND ITEGER.ITE_CODITE = :CODITE ' +
                           '  LEFT JOIN CADITE ON CADITE.ITE_CODITE = :CODITE ' +
                           ' WHERE EMP_CODEMP = :CODEMP';
    qryEmpresa.ParamByName('CODITE').AsString := AstrCodIte;
    qryEmpresa.ParamByName('CODEMP').AsString := AstrCodEmp;
    qryEmpresa.Open;

    strEstado := qryEmpresa.FieldByName('CID_ESTADO').AsString;
    If VarToStr(fCfgSis('TIPABF', varString, AstrCodEmp)) = '1' Then
      strCodAbf := qryEmpresa.FieldByName('ABF_CADITE').AsString
    Else
      strCodAbf := qryEmpresa.FieldByName('ABF_ITEGER').AsString;
  Finally
    FreeAndNil(qryEmpresa);
  End;

  fltIcmsSTParteVenda := untFuncoesSimples.fGetIcmsSTParteVenda(blnST, strCodAbf,
                                                                AEntrada.PrecoCompraLiquido,
                                                                AEntrada.IpiEntrada,
                                                                AEntrada.IcmsSaida,
                                                                strMarMkp,
                                                                strEstado);

  // Opcao 2 do host: margem, mantendo o preco de venda.
  Result := untFuncoesSimples.fCalculaPrecoVenda(2,
                                                 AEntrada.PrecoCusto + AEntrada.OutrosValores,
                                                 AEntrada.PrecoVenda,
                                                 AEntrada.MargemBruta,
                                                 AEntrada.IcmsSaida,
                                                 AEntrada.ImpostoFederal,
                                                 AEntrada.DespesaOperacional,
                                                 AEntrada.Comissao,
                                                 strMarMkp,
                                                 VarToStr(fCfgSis('PCMPRO', varString, AstrCodEmp)),
                                                 fCfgSis('DECUNI', varInteger, AstrCodEmp),
                                                 fltIcmsSTParteVenda,
                                                 blnST);
end;

{ TReformaProdutoEmpresa }

constructor TReformaProdutoEmpresa.Create(Const AstrCodEmp, AstrCodIte: String);
begin
  inherited Create;
  FqryProduto := fCriaQuery(nil);
  FqryProduto.SQL.Text := 'SELECT * FROM ITEGER WHERE ITE_CODEMP = :CODEMP AND ITE_CODITE = :CODITE';
  FqryProduto.ParamByName('CODEMP').AsString := AstrCodEmp;
  FqryProduto.ParamByName('CODITE').AsString := AstrCodIte;
  FqryProduto.Open;
end;

destructor TReformaProdutoEmpresa.Destroy;
begin
  FreeAndNil(FqryProduto);
  inherited;
end;

function TReformaProdutoEmpresa.fExiste: Boolean;
begin
  Result := Not FqryProduto.IsEmpty;
end;

function TReformaProdutoEmpresa.CodigoItem: String;
begin
  Result := FqryProduto.FieldByName('ITE_CODITE').AsString;
end;

function TReformaProdutoEmpresa.Estado: TEstadoCadastro;
begin
  Result := ecConsulta;
end;

// Campo virtual da reducao TARE e campo que o ITEGER nao tem: zero, sem reducao.
function TReformaProdutoEmpresa.ValorNumerico(Const AstrCampo: String): Double;
  Var
    fldCampo: TField;
begin
  Result := 0;

  fldCampo := FqryProduto.FindField(AstrCampo);
  If Assigned(fldCampo) And Not fldCampo.IsNull Then
    Result := fldCampo.AsFloat;
end;

function TReformaProdutoEmpresa.ValorTexto(Const AstrCampo: String): String;
  Var
    fldCampo: TField;
begin
  Result := '';

  fldCampo := FqryProduto.FindField(AstrCampo);
  If Assigned(fldCampo) Then
    Result := fldCampo.AsString;
end;

function TReformaProdutoEmpresa.FormatoExibicao(Const AstrCampo: String): String;
begin
  Result := '';
end;

function TReformaProdutoEmpresa.RotuloCampo(Const AstrCampo: String): String;
begin
  Result := '';
end;

function TReformaProdutoEmpresa.FonteDados: TDataSource;
begin
  Result := Nil;
end;

function TReformaProdutoEmpresa.ValidarCampo(Const AstrCampo: String): Boolean;
begin
  Result := True;
end;

end.
