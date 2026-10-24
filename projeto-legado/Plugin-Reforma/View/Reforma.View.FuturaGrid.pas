unit Reforma.View.FuturaGrid;

// Variante da aba 3 ("Formacao de Custo Futura") para a familia 150.x (150, 150.45, 150.100),
// cuja aba 1 de precos e um grid vertical multi-record em vez de campos soltos empilhados.
//
// Ao contrario da aba 3 classica (Reforma.View.Futura, hosts 72 e 74.111), este frame NAO herda
// daquele: sao dois desenhos independentes, e o plugin so escolhe qual export chamar
// (fReformaCriarAba3 ou fReformaCriarAba3Grid). O .dfm aqui e copia estrutural de fraPrecoProduto
// (untPrecoProdutoFrame.dfm): mesmas categorias, mesmas rows, mesmos ID/ParentID/Index. O que a
// aba 3 nao usa e escondido em codigo (pAjustarVisibilidade), nunca removido do .dfm - remover
// quebraria a numeracao que o DevExpress usa para montar a hierarquia.
//
// Layout, como na aba 1 com custo unico: pnlCusto no topo com tres grids de registro unico
// (Compra Liquido, Custo, Custo Real) e cxdPrecos embaixo, multi-record, uma coluna por tabela
// de preco. Particularidades da aba 3 em relacao a aba 1: CBS, IBS, IS e Preco de Venda com
// Impostos ficam sempre visiveis (na aba 1 dependem de CFG_REFCIS); Reducao TARE e Margem Ideal
// ficam de fora.
//
// Datasets: TSimulacaoReforma.FDados e um registro so, com as 7 tabelas achatadas em campos
// numerados (ITE_PREVE1..7, ITE_MARBR1..7, ITE_COMTB1..7, ITE_PRECL1..7) - e o que o motor de
// calculo espera. Os grids precisam de outro formato, entao ha dois espelhos alimentados a cada
// recalculo (ouvinte): FDadosCusto (1 registro, campos unicos do produto) e FDadosTabelas (1
// registro por tabela). A edicao de uma celula grava de volta no destino certo e pede o recalculo.
//
// Validacao: as faixas (ICMS saida x margem, despesas, descontos, Suframa) ja vivem em
// TValidadorPrecos, que despacha por identidade de TDBEditFocus. Para nao duplicar nenhuma regra,
// o .dfm traz um painel invisivel (pnlValidacaoFut) com um TDBEditFocus por campo unico, ligado a
// FSimulacao.Dados; a edicao no grid escreve no Text do controle e chama o validador.

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, System.SysUtils, System.Variants, Data.DB, UniClientDataSet,
  Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  cxStyles, cxClasses, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxEdit,
  cxCurrencyEdit, cxTextEdit, cxCheckBox, cxInplaceContainer, cxVGrid, cxDBVGrid,
  EditFocus, DBEditFocus,
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Host,
  Reforma.Simulacao.Modelo,
  Reforma.View.Validacao;

const
  // Postada pelo checkbox de dolar: o valor chega a simulacao depois que o grid termina o clique.
  WM_REFORMA_SINCRONIZAR = WM_USER + 702;

type
  TframeFuturaGrid = class(TFrame)
    pnlCusto: TPanel;
    cxdPrecosCompra: TcxDBVerticalGrid;
    cxdPrecosCompraCatPreCom: TcxCategoryRow;
    cxdPrecosCompraPREDOL: TcxDBEditorRow;
    cxdPrecosCompraPRECOM: TcxDBEditorRow;
    cxdPrecosCompraDESF01: TcxDBEditorRow;
    cxdPrecosCompraDESF02: TcxDBEditorRow;
    cxdPrecosCompraDESF03: TcxDBEditorRow;
    cxdPrecosCompraDESF04: TcxDBEditorRow;
    cxdPrecosCompraDESF05: TcxDBEditorRow;
    cxdPrecosCompraDESF06: TcxDBEditorRow;
    cxdPrecosCompraCOMLIQ: TcxDBEditorRow;
    cxdPrecosCusto: TcxDBVerticalGrid;
    cxCategoryRow7: TcxCategoryRow;
    cxdPrecosCustoICMENT: TcxDBEditorRow;
    cxdPrecosCustoIPIENT: TcxDBEditorRow;
    cxdPrecosCustoFREENT: TcxDBEditorRow;
    cxdPrecosCustoVALFRE: TcxDBEditorRow;
    cxdPrecosCustoACRFIN: TcxDBEditorRow;
    cxdPrecosCustoSUBSTI: TcxDBEditorRow;
    cxdPrecosCustoDESADB: TcxDBEditorRow;
    cxdPrecosCustoPRECUS: TcxDBEditorRow;
    cxdPrecosCustoReal: TcxDBVerticalGrid;
    cxCategoryRow3: TcxCategoryRow;
    cxdPrecosCustoRealTCIFCU: TcxDBEditorRow;
    cxdPrecosCustoRealTSCUST: TcxDBEditorRow;
    cxdPrecosCustoRealDEPICO: TcxDBEditorRow;
    cxdPrecosCustoRealDEICMS: TcxDBEditorRow;
    cxdPrecosCustoRealFATREG: TcxDBEditorRow;
    cxdPrecosCustoRealOUTVAL: TcxDBEditorRow;
    cxdPrecosCustoRealICMSAI: TcxDBEditorRow;
    cxdPrecosCustoRealDESOPE: TcxDBEditorRow;
    cxdPrecosCustoRealCUSREA: TcxDBEditorRow;
    cxdPrecosCustoRealCategoryREDTAR: TcxCategoryRow;
    cxdPrecosCustoRealREDTAR: TcxDBEditorRow;
    pnlSeparador: TPanel;
    cxdPrecos: TcxDBVerticalGrid;
    cxdPrecosTABELA: TcxDBEditorRow;
    cxdPrecosCatPreCom: TcxCategoryRow;
    cxdPrecosPREDOL: TcxDBEditorRow;
    cxdPrecosPRECOM: TcxDBEditorRow;
    cxdPrecosDESF01: TcxDBEditorRow;
    cxdPrecosDESF02: TcxDBEditorRow;
    cxdPrecosDESF03: TcxDBEditorRow;
    cxdPrecosDESF04: TcxDBEditorRow;
    cxdPrecosDESF05: TcxDBEditorRow;
    cxdPrecosDESF06: TcxDBEditorRow;
    cxdPrecosCOMLIQ: TcxDBEditorRow;
    cxdPrecosCatPreCus: TcxCategoryRow;
    cxdPrecosICMENT: TcxDBEditorRow;
    cxdPrecosIPIENT: TcxDBEditorRow;
    cxdPrecosFREENT: TcxDBEditorRow;
    cxdPrecosVALFRE: TcxDBEditorRow;
    cxdPrecosACRFIN: TcxDBEditorRow;
    cxdPrecosSUBSTI: TcxDBEditorRow;
    cxdPrecosDESADB: TcxDBEditorRow;
    cxdPrecosPRECUS: TcxDBEditorRow;
    cxdPrecosCatCusRea: TcxCategoryRow;
    cxdPrecosTCIFCU: TcxDBEditorRow;
    cxdPrecosTSCUST: TcxDBEditorRow;
    cxdPrecosDEPICO: TcxDBEditorRow;
    cxdPrecosDEICMS: TcxDBEditorRow;
    cxdPrecosFATREG: TcxDBEditorRow;
    cxdPrecosOUTVAL: TcxDBEditorRow;
    cxdPrecosICMSAI: TcxDBEditorRow;
    cxdPrecosDESOPE: TcxDBEditorRow;
    cxdPrecosCUSREA: TcxDBEditorRow;
    cxdPrecosCatPreVen: TcxCategoryRow;
    cxdPrecosREDTAR: TcxDBEditorRow;
    cxdPrecosUSATAR: TcxDBEditorRow;
    cxdPrecosMARBRU: TcxDBEditorRow;
    cxdPrecosMARMK3: TcxDBEditorRow;
    cxdPrecosCOMISS: TcxDBEditorRow;
    cxdPrecosPREVEN: TcxDBEditorRow;
    cxdPrecosFATPRE: TcxDBEditorRow;
    cxdPrecosCUSVEN: TcxDBEditorRow;
    cxdPrecosCBS: TcxDBEditorRow;
    cxdPrecosIBS: TcxDBEditorRow;
    cxdPrecosISVAL: TcxDBEditorRow;
    cxdPrecosPREIMP: TcxDBEditorRow;
    cxdPrecosPREVEI: TcxDBEditorRow;
    cxdPrecosPRCDOL: TcxDBEditorRow;
    cxdPrecosMARKUP: TcxDBEditorRow;
    cxdPrecosCatMarIde: TcxCategoryRow;
    cxdPrecosMARIDE: TcxDBEditorRow;
    cxdPrecosPREIDE: TcxDBEditorRow;
    cxdPrecosIMPPRE: TcxDBEditorRow;
    pnlValidacaoFut: TPanel;
    pnlCamposSuframaFut: TPanel;
    dbePreComFut: TDBEditFocus;
    dbeDesF01Fut: TDBEditFocus;
    dbeDesF02Fut: TDBEditFocus;
    dbeDesF03Fut: TDBEditFocus;
    dbeDesF04Fut: TDBEditFocus;
    dbeDesF05Fut: TDBEditFocus;
    dbeDesF06Fut: TDBEditFocus;
    dbeIcmEntFut: TDBEditFocus;
    dbeIpiEntFut: TDBEditFocus;
    dbeFreEntFut: TDBEditFocus;
    dbeValFreFut: TDBEditFocus;
    dbeAcrFinFut: TDBEditFocus;
    dbeSubstiFut: TDBEditFocus;
    dbeDesAdbFut: TDBEditFocus;
    dbeTCIFFut: TDBEditFocus;
    dbeTSFut: TDBEditFocus;
    dbeDePiCoFut: TDBEditFocus;
    dbeDeICMSFut: TDBEditFocus;
    dbeFatRegFut: TDBEditFocus;
    dbeOutValFut: TDBEditFocus;
    dbeIcmSaiFut: TDBEditFocus;
    dbeDesOpeFut: TDBEditFocus;
    cxStyleRepository: TcxStyleRepository;
    cxStyleZebra: TcxStyle;
    cxsColunaFixa: TcxStyle;
    cxsColunaFixaDestaque: TcxStyle;
    cxsPreco: TcxStyle;
    cxsMargem: TcxStyle;
    cxsTituloBlue: TcxStyle;
    cxsTituloRed: TcxStyle;
    cxsNegrito: TcxStyle;
    cxsInfoback: TcxStyle;
    cxsTituloBlack: TcxStyle;
    cxsCategoriaBlack: TcxStyle;
    dtsCalculadora: TDataSource;
    dtsCusto: TDataSource;
    dtsTabelas: TDataSource;
    // Publicados de proposito: o .dfm referencia estes metodos pelo nome e o streaming do Delphi
    // so acha metodo publicado (TReader.FindMethod -> MethodAddress). Em strict private o .dfm
    // nao carrega. Mesmos nomes do frame real, para o .dfm copiado apontar direto.
    procedure pGetDisplayTextValor(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
    procedure pGetDisplayTextPercencual(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
    procedure pGetDisplayTextFator(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
    procedure pGetContentStyle(Sender: TObject; AEditProp: TcxCustomEditorRowProperties;
      AFocused: Boolean; ARecordIndex: Integer; var AStyle: TcxStyle);
    procedure pPrecosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pCompraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pCustoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pCustoRealKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  strict private
    FHost: IReformaHost;
    FSimulacao: TSimulacaoReforma;
    FValidador: TValidadorPrecos;
    FConfiguracao: TConfiguracaoReforma;
    FDadosCusto: TUniClientDataSet;
    FDadosTabelas: TUniClientDataSet;
    FCamposUnicos: TStringList;
    FDolarVisivel: Boolean;
    // CFG_REDTAR: a aba 3 mostra a Reducao TARE da aba 1 (somente leitura).
    FReducaoTare: Boolean;
    // Operador sem EDTCUS: custo travado na alteracao, como na aba 1 (lido uma vez).
    FSemAcessoCusto: Boolean;
    FItemNroTab: Integer;
    FRowUltimoAtivo: TcxCustomRow;
    // pAtualizarCusto/pAtualizarTabelas reescrevendo os espelhos: eventos do grid nao sincronizam.
    FAtualizandoEspelho: Boolean;
    FSincronizando: Boolean;
    FPreDolPendente: string;
    function fUltimoCampoPrecoAtivo: TcxCustomRow;
    function fAlturaGrid(const Grid: TcxDBVerticalGrid): Integer;
    procedure pDimensionarGrids;
    procedure pFocar(const Grid: TcxDBVerticalGrid; const Row: TcxCustomRow);
    procedure pFormatarColunaValor(const Row: TcxDBEditorRow);
    procedure pConfigurar;
    procedure pCriarDados;
    procedure pMapearCamposUnicos;
    procedure pLigarEventos;
    procedure pAjustarVisibilidade;
    procedure pAjustarRotulos;
    function fMontarControles: TControlesPrecos;
    function fMascara(const Digitos: Integer): string;
    function fDolarAtivo: Boolean;
    function fPercentualTare: Double;
    function fUsaTare(const Tabela: Integer): Boolean;
    function fCampoUnico(const NomeCampo: string): TDBEditFocus;
    procedure pAtualizarTela(Sender: TObject);
    procedure pAtualizarCusto;
    procedure pAtualizarTabelas;
    procedure pOcultarRow(const Row: TcxCustomRow);
    procedure pTravarLinhasDoProduto;
    function fPrefixoTabela(const Linha: TcxCustomRow): string;
    procedure pGravarCampoTabela(const Sufixo: string; const Tabela: Integer; const Valor: Double);
    function fExigeValidarMargem: Boolean;
    function fMensagemMargem: string;
    function fMargemValida(const Margem, Comissao: Double): Boolean;
    function fValidarMargem(const Tabela: Integer; const Valor: Double; out Mensagem: string): Boolean;
    function fValidarComissao(const Tabela: Integer; const Valor: Double; out Mensagem: string): Boolean;
    function fValidarPrecoVenda(const Tabela: Integer; const Valor: Double; out Mensagem: string): Boolean;
    function fValidarPrecoCliente(const Tabela: Integer; const Valor: Double; out Mensagem: string): Boolean;
    function fValidarFator(const Tabela: Integer; const Valor: Double; out Mensagem: string): Boolean;
    procedure pRowMarBruValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure pRowComissValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure pRowPreVenValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure pRowPreImpValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure pRowFatPreValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure pPrecosItemChanged(Sender: TObject; AOldRow: TcxCustomRow; AOldCellIndex: Integer);
    procedure pPrecosFocusedRecordChanged(Sender: TcxVirtualVerticalGrid; APrevFocusedRecord, AFocusedRecord: Integer);
    procedure pPrecosEditing(Sender: TObject; ARowProperties: TcxCustomEditorRowProperties; var Allow: Boolean);
    procedure pPrecosExit(Sender: TObject);
    procedure pCustoItemChanged(Sender: TObject; AOldRow: TcxCustomRow; AOldCellIndex: Integer);
    procedure pCustoExit(Sender: TObject);
    procedure pPreDolEditValueChanged(Sender: TObject);
    procedure WMReformaSincronizar(var Mensagem: TMessage); message WM_REFORMA_SINCRONIZAR;
    procedure pFecharEditor(const Grid: TcxDBVerticalGrid);
    procedure pSincronizarCusto;
    procedure pSincronizarTabelas;
    procedure pAplicarPrecoDolar(const Valor: string);
    procedure pAplicarEdicaoUnico(const NomeCampo: string; const Novo: Double);
    procedure pAplicarEdicaoTabela(const Linha: TcxCustomRow; const Tabela: Integer; const Valor: Double);
    procedure pAplicarEdicaoFator(const Tabela: Integer; const Valor: Double);
  public
    constructor Criar(AOwner: TComponent; const Host: IReformaHost;
      const Simulacao: TSimulacaoReforma);
    destructor Destroy; override;
    // pgcPrecosChange do cadastro ao entrar na aba 3.
    procedure Entrar;
    // Segue o estado de edicao do cadastro (habilita ou desabilita os campos).
    procedure AplicarEstado;
    // Chamado pelo form hospedeiro antes de gravar ou trocar de aba: a celula aberta no grid nao
    // passa por OnExit quando o foco vai para o host.
    procedure ConfirmarEdicao;
  end;

implementation

{$R *.dfm}

uses
  System.Math, System.StrUtils,
  Reforma.Calculo.Formacao, Reforma.View.Estilo;

constructor TframeFuturaGrid.Criar(AOwner: TComponent; const Host: IReformaHost;
  const Simulacao: TSimulacaoReforma);
begin
  FHost := Host;
  FSimulacao := Simulacao;
  inherited Create(AOwner);
  pConfigurar;
end;

destructor TframeFuturaGrid.Destroy;
begin
  if Assigned(FSimulacao) then
    FSimulacao.RemoverOuvinte(pAtualizarTela);
  FreeAndNil(FValidador);
  FreeAndNil(FCamposUnicos);
  inherited Destroy;
end;

procedure TframeFuturaGrid.pConfigurar;
begin
  FConfiguracao := FHost.Configuracao;
  FReducaoTare := fReducaoTareAtiva(FHost);
  FSemAcessoCusto := not FHost.Acesso('EDTCUS');

  pCriarDados;
  dtsCalculadora.DataSet := FSimulacao.Dados;
  // Com o desconto PIS/COFINS ligado (REFTRI-01, RF04) a linha Preco de Compra e o preco com desconto da aba 2. O
  // campo oculto e quem diz em que campo da simulacao a linha grava (pAplicarEdicaoUnico, pSincronizarCusto).
  if FSimulacao.UsaDescontoPisCofins then
    dbePreComFut.DataField := 'ITE_PRELIQ';
  dtsCusto.DataSet := FDadosCusto;
  dtsTabelas.DataSet := FDadosTabelas;

  cxdPrecosCompra.DataController.DataSource := dtsCusto;
  cxdPrecosCusto.DataController.DataSource := dtsCusto;
  cxdPrecosCustoReal.DataController.DataSource := dtsCusto;
  cxdPrecos.DataController.DataSource := dtsTabelas;

  pMapearCamposUnicos;
  FValidador := TValidadorPrecos.Create(FHost, FSimulacao, fMontarControles);
  FSimulacao.AdicionarOuvinte(pAtualizarTela);

  FDolarVisivel := fDolarAtivo;
  pLigarEventos;
  pAjustarRotulos;
  pAjustarVisibilidade;
  // Sem o direito PROTABPR (com CFG_VISABA) so a composicao do custo (pnlCusto) aparece, como na aba 1 (teste de
  // 2026-10-16). Na aba 4 (Calculo Convert, simulacao somente leitura) as tabelas ficam.
  cxdPrecos.Visible := not (fTabelasOcultas(FHost) and not FSimulacao.SomenteLeitura);
  pTravarLinhasDoProduto;

  // Mesmas rows que fraPrecoProduto formata com custo unico (untPrecoProdutoFrame.pas, pAjustaDados).
  // OnGetDisplayText cobre a celula parada; isto cobre o editor aberto, que le DisplayFormat direto.
  pFormatarColunaValor(cxdPrecosCompraPRECOM);
  pFormatarColunaValor(cxdPrecosCustoVALFRE);
  pFormatarColunaValor(cxdPrecosCustoRealOUTVAL);
  pFormatarColunaValor(cxdPrecosOUTVAL);
  pFormatarColunaValor(cxdPrecosPREVEN);

  // DataController.Values[Registro, ItemIndex] espera o indice do DataController, que nao e
  // necessariamente Row.Index (mesmo padrao de cxdPrecosDrawValue no grid real: sempre por
  // GetItemByFieldName().ItemIndex, nunca pela posicao da row na collection).
  FItemNroTab := (cxdPrecos.DataController.GetItemByFieldName('ITE_NROTAB') as TcxDBCellEdit).ItemIndex;

  // pDimensionarGrids NAO entra aqui: le ViewInfo, que exige handle de janela, e neste ponto o
  // frame ainda nao tem Parent (Reforma.Plugin atribui depois do Criar) - daria
  // EInvalidOperation "has no parent window". O dimensionamento acontece no Entrar.
  pAcompanharCoresAba1(FHost, Self, ['Fut']);
  AplicarEstado;
  pAtualizarTela(Self);
end;

// pFormataColunaValor do frame real: casas do DECUNI do produto, no editor e no formato.
procedure TframeFuturaGrid.pFormatarColunaValor(const Row: TcxDBEditorRow);
begin
  TcxCurrencyEditProperties(Row.Properties.EditProperties).DecimalPlaces := FConfiguracao.DecimaisUnitarios;
  TcxCurrencyEditProperties(Row.Properties.EditProperties).DisplayFormat :=
    fMascara(FConfiguracao.DecimaisUnitarios) + ';-' + fMascara(FConfiguracao.DecimaisUnitarios);
end;

// Mesma conta de fRetAlturaGrid no frame real: o grid cabe exatamente nas linhas visiveis.
function TframeFuturaGrid.fAlturaGrid(const Grid: TcxDBVerticalGrid): Integer;
var
  Indice: Integer;
begin
  Result := 0;
  for Indice := 0 to Grid.ViewInfo.VisibleRowCount - 1 do
    if Grid.ViewInfo.VisibleRows[Indice].Visible then
      Result := Result + Grid.ViewInfo.CalcRowHeight(Grid.ViewInfo.VisibleRows[Indice]) + 2;
end;

// Espelha pSetaAturaGrids: sem isto os grids ficam com a altura fixa do .dfm e sobra (ou falta)
// espaco conforme as linhas escondidas por configuracao.
// Os tres grids de custo sao alLeft: a altura deles e sempre a do pnlCusto, e atribuir Height e
// ignorado assim que o alinhamento roda (no host a conta acontece antes de haver janela, por isso
// la a atribuicao "pega"). Entao a altura do painel sai do conteudo medido, nunca de Grid.Height -
// ler Grid.Height aqui fazia o painel crescer a cada entrada na aba. cxdPrecos e alClient: ocupa
// o resto, como na aba 1.
procedure TframeFuturaGrid.pDimensionarGrids;
var
  Altura: Integer;
begin
  Altura := Max(Max(fAlturaGrid(cxdPrecosCompra), fAlturaGrid(cxdPrecosCusto)),
    fAlturaGrid(cxdPrecosCustoReal));

  pnlCusto.ClientHeight := Altura + pnlSeparador.Height + 10;
end;

// Ultima linha editavel visivel do grid de precos: e nela que o Enter faz a volta para a proxima
// tabela (mesma regra de fUltimoCampoPrecoAtivo no frame real).
function TframeFuturaGrid.fUltimoCampoPrecoAtivo: TcxCustomRow;
var
  Indice: Integer;
begin
  Result := cxdPrecos.LastVisibleRow;

  for Indice := cxdPrecos.Rows.Count - 1 downto 0 do
    if (not cxdPrecos.Rows[Indice].IsCategory) and cxdPrecos.Rows[Indice].Visible and
       TcxDBEditorRow(cxdPrecos.Rows[Indice]).Properties.Options.Editing then
    begin
      Result := cxdPrecos.Rows[Indice];
      Exit;
    end;
end;

// O host usa pSetFocus (helper de untFuncoesSimples, que nao existe na DLL). A API do Windows e
// declarada com outro nome de proposito: o metodo SetFocus de TWinControl (0 parametros) ganharia
// da funcao na resolucao de nome dentro do metodo, e qualificar a chamada pela unit Winapi.Windows
// cairia na trava do pre-commit (ponto seguido de SetFocus).
function fFocarJanela(const AJanela: HWND): HWND; stdcall; external 'user32.dll' name 'SetFocus';

procedure TframeFuturaGrid.pFocar(const Grid: TcxDBVerticalGrid; const Row: TcxCustomRow);
begin
  if not Grid.CanFocus then
    Exit;

  fFocarJanela(Grid.Handle);
  if Assigned(Row) then
    Row.Focused := True;
end;

// Cadeia de Enter entre os quatro grids, igual a da aba 1: Compra -> Custo -> Custo Real -> Precos,
// e dentro de Precos o Enter na ultima linha editavel pula para a proxima tabela (coluna).
procedure TframeFuturaGrid.pCompraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and Assigned(cxdPrecosCompra.InplaceEditor) and
     (cxdPrecosCompra.FocusedRow = cxdPrecosCompraDESF06) then
  begin
    Key := 0;
    pFocar(cxdPrecosCusto, cxdPrecosCustoICMENT);
    Keybd_Event(VK_RETURN, 0, 0, 0);
  end;
end;

procedure TframeFuturaGrid.pCustoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and Assigned(cxdPrecosCusto.InplaceEditor) and
     (cxdPrecosCusto.FocusedRow = cxdPrecosCustoDESADB) then
  begin
    Key := 0;
    if cxdPrecosCustoRealTCIFCU.Visible then
      pFocar(cxdPrecosCustoReal, cxdPrecosCustoRealTCIFCU)
    else
      pFocar(cxdPrecosCustoReal, cxdPrecosCustoRealOUTVAL);
    Keybd_Event(VK_RETURN, 0, 0, 0);
  end;
end;

procedure TframeFuturaGrid.pCustoRealKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and cxdPrecos.Visible and Assigned(cxdPrecosCustoReal.InplaceEditor) and
     (cxdPrecosCustoReal.FocusedRow = cxdPrecosCustoRealDESOPE) then
  begin
    Key := 0;
    pFocar(cxdPrecos, cxdPrecosMARBRU);
    // So dispara o Enter se o foco chegou mesmo ao grid de precos: se a validacao do DESOPE reprovar,
    // o foco fica no campo invalido e um Keybd_Event incondicional recairia nele, em loop de erro.
    // A row DESOPE nao serve de criterio: segue Focused (row focada do proprio grid) depois que o
    // foco sai.
    if cxdPrecos.Focused then
      Keybd_Event(VK_RETURN, 0, 0, 0);
  end;
end;

procedure TframeFuturaGrid.pPrecosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and Assigned(cxdPrecos.InplaceEditor) and
     (cxdPrecos.FocusedRow = FRowUltimoAtivo) then
  begin
    if cxdPrecos.DataController.FocusedRecordIndex <> cxdPrecos.DataController.RecordCount - 1 then
      cxdPrecos.DataController.FocusedRecordIndex := cxdPrecos.DataController.FocusedRecordIndex + 1
    else
      cxdPrecos.DataController.FocusedRecordIndex := 0;

    Key := 0;
    cxdPrecosMARBRU.Focused := True;
    Keybd_Event(VK_RETURN, 0, 0, 0);
  end;
end;

// Os dois espelhos tem a MESMA lista de campos: as rows escondidas do cxdPrecos continuam ligadas
// por FieldName, e o DevExpress resolve o vinculo na carga do dfm, antes de qualquer Visible.
procedure TframeFuturaGrid.pCriarDados;
begin
  FDadosCusto := TUniClientDataSet.Create(Self);
  FDadosCusto.FieldDefs.Add('ITE_PREDOL', ftString, 1);
  FDadosCusto.FieldDefs.Add('ITE_PRECOM', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_DESF01', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_DESF02', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_DESF03', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_DESF04', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_DESF05', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_DESF06', ftFloat);
  FDadosCusto.FieldDefs.Add('COMLIQ', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_ICMENT', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_IPIENT', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_FREENT', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_VALFRE', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_ACRFIN', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_SUBSTI', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_DESADB', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_PRECUS', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_TCIFCU', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_TSCUST', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_DEPICO', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_DEICMS', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_FATREG', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_OUTVAL', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_ICMSAI', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_DESOPE', ftFloat);
  FDadosCusto.FieldDefs.Add('CUSREA', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_REDTAR', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_NROTAB', ftInteger);
  FDadosCusto.FieldDefs.Add('REDTAR', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_USATAR', ftString, 1);
  FDadosCusto.FieldDefs.Add('ITE_MARBRU', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_COMTBL', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_PREVEN', ftFloat);
  FDadosCusto.FieldDefs.Add('FATPRE', ftFloat);
  FDadosCusto.FieldDefs.Add('CUSVEN', ftFloat);
  FDadosCusto.FieldDefs.Add('CBS', ftFloat);
  FDadosCusto.FieldDefs.Add('IBS', ftFloat);
  FDadosCusto.FieldDefs.Add('ISVAL', ftFloat);
  FDadosCusto.FieldDefs.Add('PREIMP', ftFloat);
  FDadosCusto.FieldDefs.Add('PREVEI', ftFloat);
  FDadosCusto.FieldDefs.Add('PREDOL', ftFloat);
  FDadosCusto.FieldDefs.Add('MARKUP', ftFloat);
  FDadosCusto.FieldDefs.Add('ITE_MARIDE', ftFloat);
  FDadosCusto.FieldDefs.Add('PREIDE', ftFloat);
  FDadosCusto.FieldDefs.Add('IMPPRE', ftFloat);
  FDadosCusto.CreateDataSet;
  FDadosCusto.Append;
  FDadosCusto.Post;

  FDadosTabelas := TUniClientDataSet.Create(Self);
  FDadosTabelas.FieldDefs.Add('ITE_PREDOL', ftString, 1);
  FDadosTabelas.FieldDefs.Add('ITE_PRECOM', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_DESF01', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_DESF02', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_DESF03', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_DESF04', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_DESF05', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_DESF06', ftFloat);
  FDadosTabelas.FieldDefs.Add('COMLIQ', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_ICMENT', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_IPIENT', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_FREENT', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_VALFRE', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_ACRFIN', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_SUBSTI', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_DESADB', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_PRECUS', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_TCIFCU', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_TSCUST', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_DEPICO', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_DEICMS', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_FATREG', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_OUTVAL', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_ICMSAI', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_DESOPE', ftFloat);
  FDadosTabelas.FieldDefs.Add('CUSREA', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_REDTAR', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_NROTAB', ftInteger);
  FDadosTabelas.FieldDefs.Add('REDTAR', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_USATAR', ftString, 1);
  FDadosTabelas.FieldDefs.Add('ITE_MARBRU', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_COMTBL', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_PREVEN', ftFloat);
  FDadosTabelas.FieldDefs.Add('FATPRE', ftFloat);
  FDadosTabelas.FieldDefs.Add('CUSVEN', ftFloat);
  FDadosTabelas.FieldDefs.Add('CBS', ftFloat);
  FDadosTabelas.FieldDefs.Add('IBS', ftFloat);
  FDadosTabelas.FieldDefs.Add('ISVAL', ftFloat);
  FDadosTabelas.FieldDefs.Add('PREIMP', ftFloat);
  FDadosTabelas.FieldDefs.Add('PREVEI', ftFloat);
  FDadosTabelas.FieldDefs.Add('PREDOL', ftFloat);
  FDadosTabelas.FieldDefs.Add('MARKUP', ftFloat);
  FDadosTabelas.FieldDefs.Add('ITE_MARIDE', ftFloat);
  FDadosTabelas.FieldDefs.Add('PREIDE', ftFloat);
  FDadosTabelas.FieldDefs.Add('IMPPRE', ftFloat);
  FDadosTabelas.CreateDataSet;
  FDadosTabelas.IndexFieldNames := 'ITE_NROTAB';
end;

procedure TframeFuturaGrid.pMapearCamposUnicos;
begin
  FCamposUnicos := TStringList.Create;
  FCamposUnicos.AddObject('ITE_PRECOM', dbePreComFut);
  FCamposUnicos.AddObject('ITE_DESF01', dbeDesF01Fut);
  FCamposUnicos.AddObject('ITE_DESF02', dbeDesF02Fut);
  FCamposUnicos.AddObject('ITE_DESF03', dbeDesF03Fut);
  FCamposUnicos.AddObject('ITE_DESF04', dbeDesF04Fut);
  FCamposUnicos.AddObject('ITE_DESF05', dbeDesF05Fut);
  FCamposUnicos.AddObject('ITE_DESF06', dbeDesF06Fut);
  FCamposUnicos.AddObject('ITE_ICMENT', dbeIcmEntFut);
  FCamposUnicos.AddObject('ITE_IPIENT', dbeIpiEntFut);
  FCamposUnicos.AddObject('ITE_FREENT', dbeFreEntFut);
  FCamposUnicos.AddObject('ITE_VALFRE', dbeValFreFut);
  FCamposUnicos.AddObject('ITE_ACRFIN', dbeAcrFinFut);
  FCamposUnicos.AddObject('ITE_SUBSTI', dbeSubstiFut);
  FCamposUnicos.AddObject('ITE_DESADB', dbeDesAdbFut);
  FCamposUnicos.AddObject('ITE_TCIFCU', dbeTCIFFut);
  FCamposUnicos.AddObject('ITE_TSCUST', dbeTSFut);
  FCamposUnicos.AddObject('ITE_DEPICO', dbeDePiCoFut);
  FCamposUnicos.AddObject('ITE_DEICMS', dbeDeICMSFut);
  FCamposUnicos.AddObject('ITE_FATREG', dbeFatRegFut);
  FCamposUnicos.AddObject('ITE_OUTVAL', dbeOutValFut);
  FCamposUnicos.AddObject('ITE_ICMSAI', dbeIcmSaiFut);
  FCamposUnicos.AddObject('ITE_DESOPE', dbeDesOpeFut);
end;

// A secao de tabelas nao tem TDBEditFocus algum (e grid): os 4 arrays ficam nil, para
// TValidadorPrecos nunca classificar nada como tcMargem/tcComissao/tcPrecoVenda/tcPrecoCliente.
// A validacao das tabelas e propria desta classe; a dos campos unicos e do validador. Para a soma
// de 100% do ICMS de saida e da despesa operacional, o validador le as margens da simulacao.
function TframeFuturaGrid.fMontarControles: TControlesPrecos;
begin
  FillChar(Result, SizeOf(Result), 0);

  Result.PrecoCompra := dbePreComFut;
  Result.Descontos[1] := dbeDesF01Fut;
  Result.Descontos[2] := dbeDesF02Fut;
  Result.Descontos[3] := dbeDesF03Fut;
  Result.Descontos[4] := dbeDesF04Fut;
  Result.Descontos[5] := dbeDesF05Fut;
  Result.Descontos[6] := dbeDesF06Fut;
  Result.IcmsEntrada := dbeIcmEntFut;
  Result.IpiEntrada := dbeIpiEntFut;
  Result.FreteEntrada := dbeFreEntFut;
  Result.ValorFrete := dbeValFreFut;
  Result.AcrescimoFinanceiro := dbeAcrFinFut;
  Result.Substituicao := dbeSubstiFut;
  Result.DescontoAdicional := dbeDesAdbFut;
  Result.SuframaTcif := dbeTCIFFut;
  Result.SuframaTs := dbeTSFut;
  Result.SuframaPisCofins := dbeDePiCoFut;
  Result.SuframaIcms := dbeDeICMSFut;
  Result.SuframaFatorRegional := dbeFatRegFut;
  Result.OutrosValores := dbeOutValFut;
  Result.IcmsSaida := dbeIcmSaiFut;
  Result.DespesaOperacional := dbeDesOpeFut;
  Result.PainelSuframa := pnlCamposSuframaFut;
  Result.MargensDaSimulacao := True;
end;

function TframeFuturaGrid.fCampoUnico(const NomeCampo: string): TDBEditFocus;
var
  Indice: Integer;
begin
  Indice := FCamposUnicos.IndexOf(NomeCampo);
  if Indice < 0 then
    Result := nil
  else
    Result := TDBEditFocus(FCamposUnicos.Objects[Indice]);
end;

// fMskDigitos do host: mascara com milhar e N casas.
function TframeFuturaGrid.fMascara(const Digitos: Integer): string;
begin
  if Digitos = 0 then
    Result := '#,##0.' + StringOfChar('0', 2)
  else
    Result := '#,##0.' + StringOfChar('0', Digitos);
end;

function TframeFuturaGrid.fDolarAtivo: Boolean;
begin
  Result := FHost.ConfiguracaoBooleana('COTDOR');
end;

procedure TframeFuturaGrid.pLigarEventos;
begin
  cxdPrecos.OnItemChanged := pPrecosItemChanged;
  cxdPrecos.OnFocusedRecordChanged := pPrecosFocusedRecordChanged;
  cxdPrecos.OnEditing := pPrecosEditing;
  cxdPrecos.OnExit := pPrecosExit;
  cxdPrecosCompra.OnItemChanged := pCustoItemChanged;
  cxdPrecosCompra.OnExit := pCustoExit;
  cxdPrecosCusto.OnItemChanged := pCustoItemChanged;
  cxdPrecosCusto.OnExit := pCustoExit;
  cxdPrecosCustoReal.OnItemChanged := pCustoItemChanged;
  cxdPrecosCustoReal.OnExit := pCustoExit;

  // Mesmo efeito de chkPreDolFut.OnClick na aba 3 classica.
  cxdPrecosCompraPREDOL.Properties.EditProperties.OnEditValueChanged := pPreDolEditValueChanged;

  // Rows editaveis por tabela: so validacao aqui. Quem grava e recalcula e pSincronizarTabelas,
  // depois que a celula ja foi commitada - mesmo padrao do host (cxdPrecosXxxValidate so valida).
  cxdPrecosMARBRU.Properties.EditProperties.OnValidate := pRowMarBruValidate;
  cxdPrecosCOMISS.Properties.EditProperties.OnValidate := pRowComissValidate;
  cxdPrecosPREVEN.Properties.EditProperties.OnValidate := pRowPreVenValidate;
  cxdPrecosPREIMP.Properties.EditProperties.OnValidate := pRowPreImpValidate;
  cxdPrecosFATPRE.Properties.EditProperties.OnValidate := pRowFatPreValidate;
  // OnGetDisplayText e Styles.OnGetContentStyle de cada row ja vem do .dfm, apontando para os
  // metodos homonimos desta classe - nada a religar aqui.
end;

procedure TframeFuturaGrid.pAjustarRotulos;
var
  MargemMarkup, Comissao: string;
begin
  MargemMarkup := FHost.ConfiguracaoTexto('MARMKP');
  Comissao := FHost.ConfiguracaoTexto('PCMPRO');

  if Pos(MargemMarkup, '1_5_') = 0 then
    cxdPrecosMARBRU.Properties.Caption := 'Markup   ';
  if MargemMarkup = '4' then
    cxdPrecosCUSVEN.Properties.Caption := 'IVA   ';
  if Comissao <> '2' then
    cxdPrecosCOMISS.Properties.Caption := FHost.ConfiguracaoTexto('TCOMTB') + '   ';

  cxdPrecosOUTVAL.Properties.Caption := FHost.ConfiguracaoTexto('DOVCPP') + ' (+)   ';
  cxdPrecosCustoRealOUTVAL.Properties.Caption := cxdPrecosOUTVAL.Properties.Caption;
  cxdPrecosDESADB.Properties.Caption := FHost.ConfiguracaoTexto('DESADI') + ' (' +
    FHost.ConfiguracaoTexto('OPEADI') + ')   ';
  cxdPrecosCustoDESADB.Properties.Caption := cxdPrecosDESADB.Properties.Caption;
  cxdPrecosVALFRE.Properties.Caption := FHost.ConfiguracaoTexto('DESVFR') + ' (+)   ';
  cxdPrecosCustoVALFRE.Properties.Caption := cxdPrecosVALFRE.Properties.Caption;

  // Como na aba 1: a legenda cita a tabela padrao da empresa (EMP_TABPAD).
  if (FConfiguracao.TabelaPadrao >= 1) and (FConfiguracao.TabelaPadrao <= QUANTIDADE_TABELAS_PRECO) then
    cxdPrecosFATPRE.Properties.Caption := 'Fator Tabela ' + IntToStr(FConfiguracao.TabelaPadrao) + '   ';
end;

procedure TframeFuturaGrid.pOcultarRow(const Row: TcxCustomRow);
begin
  Row.Visible := False;
  Row.Options.TabStop := False;
end;

// O .dfm e copia da aba 1 inteira: aqui some o que a aba 3 nao usa. Esconder (e nao apagar do
// .dfm) preserva a numeracao ID/ParentID/Index que o DevExpress usa para montar a hierarquia.
procedure TframeFuturaGrid.pAjustarVisibilidade;
var
  Indice: Integer;
  Suframa: Boolean;
  Comissao: string;
  MargemMarkup: string;
begin
  MargemMarkup := FHost.ConfiguracaoTexto('MARMKP');
  Comissao := FHost.ConfiguracaoTexto('PCMPRO');
  Suframa := FHost.ConfiguracaoBooleana('SUFRAM') and (FHost.ConfiguracaoTexto('FRMCUS') = '4');

  // Compra, Custo e Custo Real vivem em pnlCusto (como na aba 1 com custo unico): as mesmas
  // categorias dentro do cxdPrecos ficam escondidas, para o dado nao aparecer em dobro.
  pOcultarRow(cxdPrecosCatPreCom);
  pOcultarRow(cxdPrecosPREDOL);
  pOcultarRow(cxdPrecosPRECOM);
  pOcultarRow(cxdPrecosDESF01);
  pOcultarRow(cxdPrecosDESF02);
  pOcultarRow(cxdPrecosDESF03);
  pOcultarRow(cxdPrecosDESF04);
  pOcultarRow(cxdPrecosDESF05);
  pOcultarRow(cxdPrecosDESF06);
  pOcultarRow(cxdPrecosCOMLIQ);
  pOcultarRow(cxdPrecosCatPreCus);
  pOcultarRow(cxdPrecosICMENT);
  pOcultarRow(cxdPrecosIPIENT);
  pOcultarRow(cxdPrecosFREENT);
  pOcultarRow(cxdPrecosVALFRE);
  pOcultarRow(cxdPrecosACRFIN);
  pOcultarRow(cxdPrecosSUBSTI);
  pOcultarRow(cxdPrecosDESADB);
  pOcultarRow(cxdPrecosPRECUS);
  pOcultarRow(cxdPrecosCatCusRea);
  pOcultarRow(cxdPrecosTCIFCU);
  pOcultarRow(cxdPrecosTSCUST);
  pOcultarRow(cxdPrecosDEPICO);
  pOcultarRow(cxdPrecosDEICMS);
  pOcultarRow(cxdPrecosFATREG);
  pOcultarRow(cxdPrecosOUTVAL);
  pOcultarRow(cxdPrecosICMSAI);
  pOcultarRow(cxdPrecosDESOPE);
  pOcultarRow(cxdPrecosCUSREA);

  // Fora de escopo na aba 3 (spec.md RN06): Margem Ideal. A Reducao TARE (CFG_REDTAR) aparece como na aba 1 com custo
  // unico e somente leitura: o percentual no Custo Real e o "Utiliza" em cada tabela (teste de 2026-10-15). A conta
  // ja usava a reducao (TCalculoFormacao.AplicarTare).
  pOcultarRow(cxdPrecosREDTAR);
  if FReducaoTare then
  begin
    cxdPrecosUSATAR.Visible := True;
    cxdPrecosUSATAR.Properties.Options.Editing := False;
    cxdPrecosUSATAR.Options.TabStop := False;
    cxdPrecosCustoRealCategoryREDTAR.Visible := True;
    cxdPrecosCustoRealREDTAR.Visible := True;
    cxdPrecosCustoRealREDTAR.Properties.Options.Editing := False;
    cxdPrecosCustoRealREDTAR.Options.TabStop := False;
  end
  else
  begin
    pOcultarRow(cxdPrecosUSATAR);
    pOcultarRow(cxdPrecosCustoRealCategoryREDTAR);
    pOcultarRow(cxdPrecosCustoRealREDTAR);
  end;
  pOcultarRow(cxdPrecosCatMarIde);
  pOcultarRow(cxdPrecosMARIDE);
  pOcultarRow(cxdPrecosPREIDE);
  pOcultarRow(cxdPrecosIMPPRE);

  // Linhas de apoio do host que a aba 3 nao reproduz.
  pOcultarRow(cxdPrecosMARMK3);
  pOcultarRow(cxdPrecosMARKUP);
  pOcultarRow(cxdPrecosPREVEI);

  // Imposto federal (entrada, saida e o detalhamento ALQFED/ALQENT do 74.111) nao aparece aqui:
  // nao e row escondida, nao existe no .dfm - CBS, IBS e IS tomam o lugar dele e ele vale zero na
  // conta (TCalculoFormacao.ZerarImpostosFederais). Ver spec.md RN13.

  cxdPrecosCompraPREDOL.Visible := fDolarAtivo;

  cxdPrecosCustoRealTCIFCU.Visible := Suframa;
  cxdPrecosCustoRealTSCUST.Visible := Suframa;
  cxdPrecosCustoRealDEPICO.Visible := Suframa;
  cxdPrecosCustoRealDEICMS.Visible := Suframa;
  cxdPrecosCustoRealFATREG.Visible := Suframa;
  pnlCamposSuframaFut.Visible := Suframa;

  cxdPrecosCOMISS.Visible := Comissao <> '1';
  cxdPrecosCUSVEN.Visible := Pos(MargemMarkup, '_1_2') > 0;
  cxdPrecosPRCDOL.Visible := FDolarVisivel;
  cxdPrecosFATPRE.Visible := FHost.ConfiguracaoBooleana('PROFAT') and
    (FConfiguracao.TabelaPadrao >= 1) and (FConfiguracao.TabelaPadrao <= QUANTIDADE_TABELAS_PRECO);

  // CBS, IBS, IS e Preco de Venda com Impostos sao a razao de ser da aba 3: sempre visiveis.
  cxdPrecosCBS.Visible := True;
  cxdPrecosIBS.Visible := True;
  cxdPrecosISVAL.Visible := True;
  cxdPrecosPREIMP.Visible := True;

  for Indice := 0 to FCamposUnicos.Count - 1 do
    TDBEditFocus(FCamposUnicos.Objects[Indice]).Visible := False;
end;

// Campo da simulacao, sem o numero da tabela, que a linha do grid de precos edita; '' nas demais linhas.
function TframeFuturaGrid.fPrefixoTabela(const Linha: TcxCustomRow): string;
begin
  if Linha = cxdPrecosMARBRU then
    Result := 'ITE_MARBR'
  else if Linha = cxdPrecosCOMISS then
    Result := 'ITE_COMTB'
  else if Linha = cxdPrecosPREVEN then
    Result := 'ITE_PREVE'
  else if Linha = cxdPrecosPREIMP then
    Result := 'ITE_PRECL'
  else if Linha = cxdPrecosFATPRE then
    Result := 'ITE_FATPR'
  else
    Result := '';
end;

// REFTRI-01 (CFG_REFCIS = 'N'): so as linhas gravadas na REFPRE continuam editaveis - a despesa operacional e, no
// grid de precos, margem, comissao e preco de venda. O resto segue o produto (TSimulacaoReforma.SincronizarProduto).
// A trava por tabela fica em pPrecosEditing. Com 'S' nada muda.
procedure TframeFuturaGrid.pTravarLinhasDoProduto;

  procedure pTravar(const Grid: TcxDBVerticalGrid);
  var
    Indice: Integer;
    Linha: TcxDBEditorRow;
    Campo: TDBEditFocus;
    Editavel: Boolean;
  begin
    for Indice := 0 to Grid.Rows.Count - 1 do
      if Grid.Rows[Indice] is TcxDBEditorRow then
      begin
        Linha := TcxDBEditorRow(Grid.Rows[Indice]);
        if Grid = cxdPrecos then
          Editavel := (fPrefixoTabela(Linha) <> '') and FSimulacao.CampoEditavel(fPrefixoTabela(Linha) + '1')
        else
        begin
          // Os grids de custo gravam pelo campo oculto (pAplicarEdicaoUnico): e ele que diz o campo da simulacao.
          Campo := fCampoUnico(Linha.Properties.DataBinding.FieldName);
          Editavel := Assigned(Campo) and FSimulacao.CampoEditavel(Campo.DataField);
        end;

        if not Editavel then
        begin
          Linha.Properties.Options.Editing := False;
          Linha.Options.TabStop := False;
        end;
      end;
  end;

begin
  if not FSimulacao.UsaDescontoPisCofins then
    Exit;

  pTravar(cxdPrecosCompra);
  pTravar(cxdPrecosCusto);
  pTravar(cxdPrecosCustoReal);
  pTravar(cxdPrecos);
end;

procedure TframeFuturaGrid.Entrar;
begin
  // Abrir a aba nao e edicao do usuario: nao marca pendencia.
  FSimulacao.ExecutarSemMarcar(
    procedure
    begin
      FSimulacao.Recalcular(grExibicao);
    end);
  pAtualizarTela(Self);
  // pAtualizarTela pode ter mudado a visibilidade da linha de dolar: redimensiona depois dela.
  FRowUltimoAtivo := fUltimoCampoPrecoAtivo;
  pDimensionarGrids;
end;

procedure TframeFuturaGrid.AplicarEstado;
var
  Editavel: Boolean;
  CustoEditavel: Boolean;
begin
  // Empresa que recebe os precos da matriz so consulta, como a aba 1 dela; sem EDTCUS os tres grids de custo travam
  // na alteracao, como TfraPrecoProduto.pBloqueiaCusto (teste de 2026-10-15).
  Editavel := not FConfiguracao.PrecosDaMatriz and (FHost.Produto.Estado in [ecInclusao, ecAlteracao]);
  CustoEditavel := Editavel and not fCustoBloqueado(FHost, FSemAcessoCusto);
  cxdPrecos.Enabled := Editavel;
  cxdPrecosCompra.Enabled := CustoEditavel;
  cxdPrecosCusto.Enabled := CustoEditavel;
  cxdPrecosCustoReal.Enabled := CustoEditavel;
end;

procedure TframeFuturaGrid.pAtualizarTela(Sender: TObject);
begin
  FDolarVisivel := fDolarAtivo and (FHost.CotacaoDolarVenda > 0);
  cxdPrecosPRCDOL.Visible := FDolarVisivel;
  pAtualizarCusto;
  pAtualizarTabelas;
end;

// Percentual da Reducao TARE como a aba 1 com custo unico mostra: o da primeira tabela ativa. Exe anterior ao contrato
// 13 nao informa o percentual sem o "Utiliza": vale o percentual aplicado.
function TframeFuturaGrid.fPercentualTare: Double;
var
  Tabela: Integer;
begin
  Result := 0;
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    if FConfiguracao.TabelaAtiva[Tabela] then
    begin
      Result := FHost.Produto.ValorNumerico(CAMPO_PERCENTUAL_TARE + IntToStr(Tabela));
      if Result = 0 then
        Result := FHost.Produto.ValorNumerico(CAMPO_REDUCAO_TARE + IntToStr(Tabela));
      Exit;
    end;
end;

function TframeFuturaGrid.fUsaTare(const Tabela: Integer): Boolean;
begin
  Result := (FHost.Produto.ValorNumerico(CAMPO_USA_TARE + IntToStr(Tabela)) <> 0) or
    (FHost.Produto.ValorNumerico(CAMPO_REDUCAO_TARE + IntToStr(Tabela)) <> 0);
end;

// Espelho de registro unico: os campos do produto que nao variam por tabela.
procedure TframeFuturaGrid.pAtualizarCusto;
var
  Indice: Integer;
begin
  if not Assigned(FDadosCusto) or not FDadosCusto.Active then
    Exit;

  FAtualizandoEspelho := True;
  FDadosCusto.DisableControls;
  Try
    FDadosCusto.Edit;
    if FSimulacao.Formacao.Custo.ConverterMoeda then
      FDadosCusto.FieldByName('ITE_PREDOL').AsString := 'S'
    else
      FDadosCusto.FieldByName('ITE_PREDOL').AsString := 'N';
    if FSimulacao.UsaDescontoPisCofins then
      FDadosCusto.FieldByName('ITE_PRECOM').AsFloat := FSimulacao.Formacao.PrecoCompraComDesconto
    else
      FDadosCusto.FieldByName('ITE_PRECOM').AsFloat := FSimulacao.Formacao.Custo.PrecoCompra;
    for Indice := Low(FSimulacao.Formacao.Custo.Descontos) to High(FSimulacao.Formacao.Custo.Descontos) do
      FDadosCusto.FieldByName('ITE_DESF0' + IntToStr(Indice)).AsFloat :=
        FSimulacao.Formacao.Custo.Descontos[Indice];
    FDadosCusto.FieldByName('COMLIQ').AsFloat := FSimulacao.Formacao.PrecoCompraLiquido;
    FDadosCusto.FieldByName('ITE_ICMENT').AsFloat := FSimulacao.Formacao.Custo.IcmsEntrada;
    FDadosCusto.FieldByName('ITE_IPIENT').AsFloat := FSimulacao.Formacao.Custo.IpiEntrada;
    FDadosCusto.FieldByName('ITE_FREENT').AsFloat := FSimulacao.Formacao.Custo.FreteEntrada;
    FDadosCusto.FieldByName('ITE_VALFRE').AsFloat := FSimulacao.Formacao.Custo.ValorFrete;
    FDadosCusto.FieldByName('ITE_ACRFIN').AsFloat := FSimulacao.Formacao.Custo.AcrescimoFinanceiro;
    FDadosCusto.FieldByName('ITE_SUBSTI').AsFloat := FSimulacao.Formacao.Custo.Substituicao;
    FDadosCusto.FieldByName('ITE_DESADB').AsFloat := FSimulacao.Formacao.Custo.DescontoAdicional;
    FDadosCusto.FieldByName('ITE_PRECUS').AsFloat := FSimulacao.Formacao.PrecoCusto;
    FDadosCusto.FieldByName('ITE_TCIFCU').AsFloat := FSimulacao.Formacao.Custo.SuframaTcif;
    FDadosCusto.FieldByName('ITE_TSCUST').AsFloat := FSimulacao.Formacao.Custo.SuframaTs;
    FDadosCusto.FieldByName('ITE_DEPICO').AsFloat := FSimulacao.Formacao.Custo.SuframaDescontoPisCofins;
    FDadosCusto.FieldByName('ITE_DEICMS').AsFloat := FSimulacao.Formacao.Custo.SuframaDescontoIcms;
    FDadosCusto.FieldByName('ITE_FATREG').AsFloat := FSimulacao.Formacao.Custo.SuframaFatorRegional;
    FDadosCusto.FieldByName('ITE_OUTVAL').AsFloat := FSimulacao.Formacao.OutrosValores;
    FDadosCusto.FieldByName('ITE_ICMSAI').AsFloat := FSimulacao.Formacao.IcmsSaida;
    FDadosCusto.FieldByName('ITE_DESOPE').AsFloat := FSimulacao.Formacao.DespesaOperacional;
    FDadosCusto.FieldByName('CUSREA').AsFloat := FSimulacao.Formacao.CustoReal;
    if FReducaoTare then
      FDadosCusto.FieldByName('ITE_REDTAR').AsFloat := fPercentualTare;
    FDadosCusto.Post;
  Finally
    FDadosCusto.EnableControls;
    FAtualizandoEspelho := False;
  End;
end;

// Espelho multi-record: 1 registro por tabela ativa. Edit/Post por tabela (nao recria do zero):
// preserva a celula/registro focado entre uma notificacao e outra. Com GridMode o registro focado
// e o do cursor, e o Locate do laco o leva para a ultima tabela: a tabela focada volta no fim.
procedure TframeFuturaGrid.pAtualizarTabelas;
var
  Tabela: Integer;
  TabelaFocada: Integer;
  Cotacao: Double;
begin
  if not Assigned(FDadosTabelas) or not FDadosTabelas.Active then
    Exit;

  Cotacao := FHost.CotacaoDolarVenda;

  TabelaFocada := 0;
  if not FDadosTabelas.IsEmpty then
    TabelaFocada := FDadosTabelas.FieldByName('ITE_NROTAB').AsInteger;

  FAtualizandoEspelho := True;
  FDadosTabelas.DisableControls;
  Try
    for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    begin
      if not FConfiguracao.TabelaAtiva[Tabela] then
        Continue;

      if not FDadosTabelas.Locate('ITE_NROTAB', Tabela, []) then
      begin
        FDadosTabelas.Append;
        FDadosTabelas.FieldByName('ITE_NROTAB').AsInteger := Tabela;
      end
      else
        FDadosTabelas.Edit;

      FDadosTabelas.FieldByName('ITE_MARBRU').AsFloat := FSimulacao.Formacao.Tabelas[Tabela].MargemBruta;
      FDadosTabelas.FieldByName('ITE_COMTBL').AsFloat := FSimulacao.Formacao.Tabelas[Tabela].Comissao;
      FDadosTabelas.FieldByName('ITE_PREVEN').AsFloat := FSimulacao.Formacao.Tabelas[Tabela].PrecoVenda;
      FDadosTabelas.FieldByName('CUSVEN').AsFloat := FSimulacao.Formacao.Tabelas[Tabela].CustoVenda;
      // PREIMP na aba 1 e "Preco de Venda c/ Impostos": aqui e o preco pago pelo cliente, ja com
      // CBS, IBS e IS - o mesmo numero, pela mesma conta.
      FDadosTabelas.FieldByName('PREIMP').AsFloat := FSimulacao.Formacao.Tabelas[Tabela].PrecoCliente;
      FDadosTabelas.FieldByName('CBS').AsFloat := FSimulacao.Formacao.Aliquotas.Cbs;
      FDadosTabelas.FieldByName('IBS').AsFloat := FSimulacao.Formacao.Aliquotas.Ibs;
      FDadosTabelas.FieldByName('ISVAL').AsFloat := FSimulacao.Formacao.Aliquotas.ImpostoSeletivo;
      // A tabela padrao nao tem fator (o host deixa FATPRE nulo nela): celula em branco.
      if Tabela = FConfiguracao.TabelaPadrao then
        FDadosTabelas.FieldByName('FATPRE').Clear
      else
        FDadosTabelas.FieldByName('FATPRE').AsFloat := FSimulacao.Formacao.Tabelas[Tabela].FatorTabela;
      if FDolarVisivel and (Cotacao > 0) then
        FDadosTabelas.FieldByName('PREDOL').AsFloat := FSimulacao.Formacao.Tabelas[Tabela].PrecoVenda / Cotacao
      else
        FDadosTabelas.FieldByName('PREDOL').AsFloat := 0;
      if FReducaoTare and fUsaTare(Tabela) then
        FDadosTabelas.FieldByName('ITE_USATAR').AsString := 'S'
      else
        FDadosTabelas.FieldByName('ITE_USATAR').AsString := 'N';

      FDadosTabelas.Post;
    end;

    if (TabelaFocada = 0) or not FDadosTabelas.Locate('ITE_NROTAB', TabelaFocada, []) then
      FDadosTabelas.First;
  Finally
    FDadosTabelas.EnableControls;
    FAtualizandoEspelho := False;
  End;
end;

procedure TframeFuturaGrid.pGravarCampoTabela(const Sufixo: string; const Tabela: Integer; const Valor: Double);
begin
  if not (FSimulacao.Dados.State in dsEditModes) then
    FSimulacao.Dados.Edit;
  FSimulacao.Dados.FieldByName('ITE_' + Sufixo + IntToStr(Tabela)).AsFloat := Valor;
end;

// Os 4 espacos sao do host (pGetDisplayTextValor de untPrecoProdutoFrame.pas): ocupam o lugar do ' %'
// das linhas de percentual, para os numeros das duas terminarem na mesma coluna.
procedure TframeFuturaGrid.pGetDisplayTextValor(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  if AText <> '' then
    AText := FormatFloat(fMascara(FConfiguracao.DecimaisUnitarios), FHost.TextoParaNumero(AText)) + '    ';
end;

procedure TframeFuturaGrid.pGetDisplayTextPercencual(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  if AText <> '' then
    AText := FormatFloat(fMascara(2), FHost.TextoParaNumero(AText)) + ' %';
end;

procedure TframeFuturaGrid.pGetDisplayTextFator(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  if AText <> '' then
    AText := FormatFloat(fMascara(4), FHost.TextoParaNumero(AText)) + '    ';
end;

// Mesmo papel de cxdPrecosStylesGetContentStyle no frame real: realce da celula com foco e
// sombreado de coluna fixa no Fator da propria tabela padrao (que nao tem fator).
procedure TframeFuturaGrid.pGetContentStyle(Sender: TObject; AEditProp: TcxCustomEditorRowProperties;
  AFocused: Boolean; ARecordIndex: Integer; var AStyle: TcxStyle);
begin
  if (AEditProp.Row = cxdPrecosFATPRE) and
     (cxdPrecos.DataController.Values[ARecordIndex, FItemNroTab] = FConfiguracao.TabelaPadrao) then
    AStyle := cxsColunaFixa;

  if TcxDBVerticalGrid(Sender).Focused and (AEditProp.Row is TcxDBEditorRow) and AFocused then
    AStyle := cxsInfoback;
end;

// Margem (1 e 5), markup (2) e as demais formulas (3 e 4): mesma regra de TValidadorPrecos.
function TframeFuturaGrid.fExigeValidarMargem: Boolean;
begin
  Result := FConfiguracao.MargemMarkup in [1, 2, 5];
end;

function TframeFuturaGrid.fMensagemMargem: string;
begin
  Result := 'A soma do ( ICMS Sa'#237'da + Despesas Operacionais + Margem Bruta ';
  if FHost.ConfiguracaoTexto('PCMPRO') = '2' then
    Result := Result + '+ Comiss'#227'o ';
  Result := Result + '  ) n'#227'o pode ser superior a 100%.';
end;

// ICMS de saida e despesa operacional sao campos unicos: nao variam por tabela. O imposto federal
// fica fora da soma (vale zero na simulacao, spec.md RN13).
function TframeFuturaGrid.fMargemValida(const Margem, Comissao: Double): Boolean;
var
  MargemAjustada: Double;
begin
  MargemAjustada := Margem;
  if FConfiguracao.MargemMarkup = 2 then
    MargemAjustada := FHost.CalculoMargem.MarkupParaMargem(MargemAjustada);

  Result := not ((MargemAjustada + Comissao +
                  FSimulacao.Dados.FieldByName('ITE_ICMSAI').AsFloat +
                  FSimulacao.Dados.FieldByName('ITE_DESOPE').AsFloat) > 100);
end;

function TframeFuturaGrid.fValidarMargem(const Tabela: Integer; const Valor: Double; out Mensagem: string): Boolean;
begin
  Result := True;
  Mensagem := '';

  if not fExigeValidarMargem then
    Exit;

  if (Valor >= 100) and (FConfiguracao.MargemMarkup <> 2) then
  begin
    Mensagem := 'Margem n'#227'o permitida: maior ou igual a 100!';
    Result := False;
    Exit;
  end;

  if not fMargemValida(Valor, FSimulacao.Dados.FieldByName('ITE_COMTB' + IntToStr(Tabela)).AsFloat) then
  begin
    Mensagem := fMensagemMargem;
    Result := False;
  end;
end;

function TframeFuturaGrid.fValidarComissao(const Tabela: Integer; const Valor: Double; out Mensagem: string): Boolean;
begin
  Result := True;
  Mensagem := '';

  if not fExigeValidarMargem then
    Exit;

  if (Valor >= 100) and (FConfiguracao.MargemMarkup <> 2) then
  begin
    Mensagem := 'Comiss'#227'o n'#227'o permitida: maior ou igual a 100!';
    Result := False;
    Exit;
  end;

  if (Valor < 0) and (FConfiguracao.MargemMarkup <> 2) then
  begin
    Mensagem := 'Comiss'#227'o n'#227'o permitida: menor que zero!';
    Result := False;
    Exit;
  end;

  if not fMargemValida(FSimulacao.Dados.FieldByName('ITE_MARBR' + IntToStr(Tabela)).AsFloat, Valor) then
  begin
    Mensagem := fMensagemMargem;
    Result := False;
  end;
end;

function TframeFuturaGrid.fValidarPrecoVenda(const Tabela: Integer; const Valor: Double; out Mensagem: string): Boolean;
begin
  Result := Valor > 0;
  if not Result then
    Mensagem := 'O Pre'#231'o de Venda ' + IntToStr(Tabela) + ' deve ser maior que zero!'
  else
    Mensagem := '';
end;

function TframeFuturaGrid.fValidarPrecoCliente(const Tabela: Integer; const Valor: Double; out Mensagem: string): Boolean;
begin
  Result := Valor > 0;
  if not Result then
    Mensagem := 'O Pre'#231'o pago pelo cliente ' + IntToStr(Tabela) + ' deve ser maior que zero!'
  else
    Mensagem := '';
end;

// Mesma regra de TValidaPrecoProduto.fValidaFatorPreco no host.
function TframeFuturaGrid.fValidarFator(const Tabela: Integer; const Valor: Double; out Mensagem: string): Boolean;
begin
  Result := Valor > 0;
  if not Result then
    Mensagem := 'O fator de pre'#231'o da tabela ' + IntToStr(Tabela) + ' deve ser maior que zero!'
  else
    Mensagem := '';
end;

procedure TframeFuturaGrid.pRowMarBruValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  Mensagem: string;
begin
  if not fValidarMargem(FDadosTabelas.FieldByName('ITE_NROTAB').AsInteger,
                        FHost.TextoParaNumero(VarToStr(DisplayValue)), Mensagem) then
  begin
    FHost.Mensagem('ATEN'#199#195'O!', Mensagem);
    ErrorText := '';
    Error := True;
  end;
end;

procedure TframeFuturaGrid.pRowComissValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  Mensagem: string;
begin
  if not fValidarComissao(FDadosTabelas.FieldByName('ITE_NROTAB').AsInteger,
                          FHost.TextoParaNumero(VarToStr(DisplayValue)), Mensagem) then
  begin
    FHost.Mensagem('ATEN'#199#195'O!', Mensagem);
    ErrorText := '';
    Error := True;
  end;
end;

procedure TframeFuturaGrid.pRowPreVenValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  Mensagem: string;
begin
  if not fValidarPrecoVenda(FDadosTabelas.FieldByName('ITE_NROTAB').AsInteger,
                            FHost.TextoParaNumero(VarToStr(DisplayValue)), Mensagem) then
  begin
    FHost.Mensagem('', Mensagem);
    ErrorText := '';
    Error := True;
  end;
end;

procedure TframeFuturaGrid.pRowPreImpValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  Mensagem: string;
begin
  if not fValidarPrecoCliente(FDadosTabelas.FieldByName('ITE_NROTAB').AsInteger,
                              FHost.TextoParaNumero(VarToStr(DisplayValue)), Mensagem) then
  begin
    FHost.Mensagem('', Mensagem);
    ErrorText := '';
    Error := True;
  end;
end;

procedure TframeFuturaGrid.pRowFatPreValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  Mensagem: string;
begin
  if not fValidarFator(FDadosTabelas.FieldByName('ITE_NROTAB').AsInteger,
                       FHost.TextoParaNumero(VarToStr(DisplayValue)), Mensagem) then
  begin
    FHost.Mensagem('', Mensagem);
    ErrorText := '';
    Error := True;
  end;
end;

// Reaproveita o validador em vez de repetir as faixas aqui. O valor vai DIRETO para o campo de
// FSimulacao.Dados: um TDBEdit so passa o Text para o campo quando ele mesmo perde o foco, e o
// controle oculto nunca tem foco - escrever so no Text fazia o Recalcular ler o valor antigo e
// repintar o grid com ele. Com o campo gravado, o datalink atualiza o Text que o validador le.
// Reprovado: o validador ja mostrou a mensagem; o valor anterior volta e o foco segue para o
// proximo campo normalmente (nao e segurado na linha).
procedure TframeFuturaGrid.pAplicarEdicaoUnico(const NomeCampo: string; const Novo: Double);
var
  Campo: TDBEditFocus;
  Anterior: Double;
begin
  Campo := fCampoUnico(NomeCampo);
  if not Assigned(Campo) then
    Exit;

  // NomeCampo e o do espelho; o da simulacao e o do campo oculto (Preco de Compra vira ITE_PRELIQ, REFTRI-01).
  Anterior := FSimulacao.Dados.FieldByName(Campo.DataField).AsFloat;

  if not (FSimulacao.Dados.State in dsEditModes) then
    FSimulacao.Dados.Edit;
  FSimulacao.Dados.FieldByName(Campo.DataField).AsFloat := Novo;

  if not FValidador.Validar(Campo, False) then
  begin
    if not (FSimulacao.Dados.State in dsEditModes) then
      FSimulacao.Dados.Edit;
    FSimulacao.Dados.FieldByName(Campo.DataField).AsFloat := Anterior;
    // O Validar reprovado ainda roda grExibicao com o valor ruim: recalcula de novo com o restaurado.
    FSimulacao.Recalcular(grExibicao);
  end;

  pAtualizarTela(Self);
end;

// Mesma conta de chkPreDolFut.OnClick (Reforma.View.Futura.pPrecoDolarClick): a conversao muda o
// preco de compra liquido, entao o custo e revalidado pelo preco de compra. Sem preco de compra so
// rele a formacao, para o espelho nao voltar ao valor anterior.
procedure TframeFuturaGrid.pAplicarPrecoDolar(const Valor: string);
begin
  if (Valor = '') or FSimulacao.Dados.IsEmpty or
     (Valor = FSimulacao.Dados.FieldByName('ITE_PREDOL').AsString) then
    Exit;

  if not (FSimulacao.Dados.State in dsEditModes) then
    FSimulacao.Dados.Edit;
  FSimulacao.Dados.FieldByName('ITE_PREDOL').AsString := Valor;

  if FSimulacao.Dados.FieldByName('ITE_PRECOM').AsFloat <> 0 then
    FValidador.Validar(dbePreComFut, False)
  else
    FSimulacao.Recalcular(grExibicao);

  pAtualizarTela(Self);
end;

// O fator nao tem campo no dataset da simulacao (FATPRE nao e coluna de ITEGER): vai direto para
// a formacao, e o motor deriva o preco de venda a partir do preco da tabela padrao. Sem grExibicao
// depois: grFatorTabela ja recalcula preco cliente e custo de venda.
procedure TframeFuturaGrid.pAplicarEdicaoFator(const Tabela: Integer; const Valor: Double);
begin
  if Tabela = FConfiguracao.TabelaPadrao then
    Exit;

  FSimulacao.DefinirFatorTabela(Tabela, Valor);
  FSimulacao.Recalcular(grFatorTabela, Tabela);
end;

// Grava no destino certo e manda recalcular. O Recalcular dispara o ouvinte (pAtualizarTela), que
// repopula os espelhos com os valores oficiais pos-calculo.
procedure TframeFuturaGrid.pAplicarEdicaoTabela(const Linha: TcxCustomRow; const Tabela: Integer;
  const Valor: Double);
var
  Gatilho: TGatilhoRecalculo;
  Sufixo: string;
begin
  if Linha = cxdPrecosFATPRE then
  begin
    pAplicarEdicaoFator(Tabela, Valor);
    Exit;
  end;

  if Linha = cxdPrecosMARBRU then
  begin
    Sufixo := 'MARBR';
    Gatilho := grMargem;
  end
  else if Linha = cxdPrecosCOMISS then
  begin
    Sufixo := 'COMTB';
    Gatilho := grComissao;
  end
  else if Linha = cxdPrecosPREVEN then
  begin
    Sufixo := 'PREVE';
    Gatilho := grPrecoVenda;
  end
  else if Linha = cxdPrecosPREIMP then
  begin
    Sufixo := 'PRECL';
    Gatilho := grPrecoCliente;
  end
  else
    Exit;

  pGravarCampoTabela(Sufixo, Tabela, Valor);
  FSimulacao.Recalcular(Gatilho, Tabela);
  if Linha = cxdPrecosMARBRU then
    FSimulacao.DefinirFormatoMargem(Tabela, 2);
  FSimulacao.Recalcular(grExibicao);
end;

// Campos unicos editados no espelho que ainda nao chegaram a simulacao. Coleta tudo antes de
// aplicar: cada aplicacao recalcula e reescreve o espelho com os valores oficiais. Navegar sem
// editar nao acha diferenca e nao recalcula.
procedure TframeFuturaGrid.pSincronizarCusto;
var
  Indice: Integer;
  Quantidade: Integer;
  Nomes: array of string;
  Valores: array of Double;
  PrecoDolar: string;
begin
  if FSincronizando or FAtualizandoEspelho or not Assigned(FDadosCusto) or not FDadosCusto.Active or
     FSimulacao.Dados.IsEmpty then
    Exit;

  FSincronizando := True;
  Try
    if FDadosCusto.State in dsEditModes then
      FDadosCusto.Post;

    Quantidade := 0;
    SetLength(Nomes, FCamposUnicos.Count);
    SetLength(Valores, FCamposUnicos.Count);
    for Indice := 0 to FCamposUnicos.Count - 1 do
      if not SameValue(FDadosCusto.FieldByName(FCamposUnicos[Indice]).AsFloat,
                       FSimulacao.Dados.FieldByName(
                         TDBEditFocus(FCamposUnicos.Objects[Indice]).DataField).AsFloat) then
      begin
        Nomes[Quantidade] := FCamposUnicos[Indice];
        Valores[Quantidade] := FDadosCusto.FieldByName(FCamposUnicos[Indice]).AsFloat;
        Inc(Quantidade);
      end;
    PrecoDolar := FDadosCusto.FieldByName('ITE_PREDOL').AsString;

    pAplicarPrecoDolar(PrecoDolar);
    for Indice := 0 to Quantidade - 1 do
      pAplicarEdicaoUnico(Nomes[Indice], Valores[Indice]);
  Finally
    FSincronizando := False;
  End;
end;

// Celulas do espelho de tabelas que ainda nao chegaram a simulacao. Cada registro carrega a propria
// tabela (ITE_NROTAB), entao comparar com a formacao vale para qualquer caminho de edicao - troca de
// linha, troca de tabela (o grid grava o registro antes de mudar), Enter na ultima linha, saida do
// grid, Gravar com a celula aberta - sem depender do indice que o evento entrega (AOldCellIndex e a
// celula dentro da row, nao o registro). Navegar sem editar nao acha diferenca e nao recalcula.
procedure TframeFuturaGrid.pSincronizarTabelas;
type
  TEdicaoTabela = record
    Linha: TcxCustomRow;
    Tabela: Integer;
    Valor: Double;
  end;
var
  Edicoes: array of TEdicaoTabela;
  Quantidade: Integer;
  Indice: Integer;
  Tabela: Integer;
  TabelaFocada: Integer;

  procedure pComparar(const Linha: TcxCustomRow; const NomeCampo: string; const Oficial: Double);
  begin
    if FDadosTabelas.FieldByName(NomeCampo).IsNull or
       SameValue(FDadosTabelas.FieldByName(NomeCampo).AsFloat, Oficial) then
      Exit;

    Edicoes[Quantidade].Linha := Linha;
    Edicoes[Quantidade].Tabela := Tabela;
    Edicoes[Quantidade].Valor := FDadosTabelas.FieldByName(NomeCampo).AsFloat;
    Inc(Quantidade);
  end;

begin
  if FSincronizando or FAtualizandoEspelho or not Assigned(FDadosTabelas) or not FDadosTabelas.Active or
     FDadosTabelas.IsEmpty then
    Exit;

  FSincronizando := True;
  Try
    if FDadosTabelas.State in dsEditModes then
      FDadosTabelas.Post;

    Quantidade := 0;
    SetLength(Edicoes, FDadosTabelas.RecordCount * 5);
    TabelaFocada := FDadosTabelas.FieldByName('ITE_NROTAB').AsInteger;

    FDadosTabelas.DisableControls;
    Try
      FDadosTabelas.First;
      while not FDadosTabelas.Eof do
      begin
        Tabela := FDadosTabelas.FieldByName('ITE_NROTAB').AsInteger;
        if (Tabela >= 1) and (Tabela <= QUANTIDADE_TABELAS_PRECO) then
        begin
          pComparar(cxdPrecosMARBRU, 'ITE_MARBRU', FSimulacao.Formacao.Tabelas[Tabela].MargemBruta);
          pComparar(cxdPrecosCOMISS, 'ITE_COMTBL', FSimulacao.Formacao.Tabelas[Tabela].Comissao);
          pComparar(cxdPrecosPREVEN, 'ITE_PREVEN', FSimulacao.Formacao.Tabelas[Tabela].PrecoVenda);
          pComparar(cxdPrecosPREIMP, 'PREIMP', FSimulacao.Formacao.Tabelas[Tabela].PrecoCliente);
          if Tabela <> FConfiguracao.TabelaPadrao then
            pComparar(cxdPrecosFATPRE, 'FATPRE', FSimulacao.Formacao.Tabelas[Tabela].FatorTabela);
        end;
        FDadosTabelas.Next;
      end;

      FDadosTabelas.Locate('ITE_NROTAB', TabelaFocada, []);
    Finally
      FDadosTabelas.EnableControls;
    End;

    for Indice := 0 to Quantidade - 1 do
      pAplicarEdicaoTabela(Edicoes[Indice].Linha, Edicoes[Indice].Tabela, Edicoes[Indice].Valor);
  Finally
    FSincronizando := False;
  End;
end;

procedure TframeFuturaGrid.pPrecosItemChanged(Sender: TObject; AOldRow: TcxCustomRow; AOldCellIndex: Integer);
begin
  pSincronizarTabelas;
end;

// Troca de tabela (clique em outra coluna ou Enter na ultima linha): o OnItemChanged nao dispara
// quando a row nao muda, mas o grid ja gravou o registro anterior no espelho.
procedure TframeFuturaGrid.pPrecosFocusedRecordChanged(Sender: TcxVirtualVerticalGrid;
  APrevFocusedRecord, AFocusedRecord: Integer);
begin
  pSincronizarTabelas;
end;

// A tabela padrao nao tem fator (celula em branco, sombreada em pGetContentStyle): nao abre editor.
procedure TframeFuturaGrid.pPrecosEditing(Sender: TObject; ARowProperties: TcxCustomEditorRowProperties;
  var Allow: Boolean);
begin
  if (ARowProperties.Row = cxdPrecosFATPRE) and not FDadosTabelas.IsEmpty and
     (FDadosTabelas.FieldByName('ITE_NROTAB').AsInteger = FConfiguracao.TabelaPadrao) then
    Allow := False;

  // CFG_REFCIS = 'N' (REFTRI-01): so abre editor na celula cujo campo da tabela e coluna da REFPRE. Tambem trava margem,
  // preco e Fator Tabela da tabela com fator de preco ativo (CFG_FATPRE), que seguem a tabela 1.
  if Allow and not FDadosTabelas.IsEmpty and
     not FSimulacao.CampoEditavel(fPrefixoTabela(ARowProperties.Row) +
                                  FDadosTabelas.FieldByName('ITE_NROTAB').AsString) then
    Allow := False;
end;

procedure TframeFuturaGrid.pPrecosExit(Sender: TObject);
begin
  pSincronizarTabelas;
end;

// Os tres grids de pnlCusto so tem campo unico: um caminho so para todos.
procedure TframeFuturaGrid.pCustoItemChanged(Sender: TObject; AOldRow: TcxCustomRow; AOldCellIndex: Integer);
begin
  pSincronizarCusto;
end;

procedure TframeFuturaGrid.pCustoExit(Sender: TObject);
begin
  pSincronizarCusto;
end;

// O checkbox nao troca de linha: sem isto a conversao so valeria ao sair dela. O valor sai do
// editor e e aplicado depois que o grid termina o clique.
procedure TframeFuturaGrid.pPreDolEditValueChanged(Sender: TObject);
begin
  if not (Sender is TcxCustomEdit) then
    Exit;

  FPreDolPendente := VarToStr(TcxCustomEdit(Sender).EditValue);
  if HandleAllocated then
    PostMessage(Handle, WM_REFORMA_SINCRONIZAR, 0, 0);
end;

procedure TframeFuturaGrid.WMReformaSincronizar(var Mensagem: TMessage);
var
  Valor: string;
begin
  Valor := FPreDolPendente;
  FPreDolPendente := '';
  if FSincronizando or FAtualizandoEspelho then
    Exit;

  FSincronizando := True;
  Try
    pAplicarPrecoDolar(Valor);
  Finally
    FSincronizando := False;
  End;
end;

// Valor reprovado pelo OnValidate (a mensagem ja saiu): descarta a digitacao em vez de deixar a
// excecao de validacao chegar ao host, que desligaria o plugin.
procedure TframeFuturaGrid.pFecharEditor(const Grid: TcxDBVerticalGrid);
begin
  if not Grid.IsEditing then
    Exit;

  try
    Grid.HideEdit;
  except
    Grid.CancelEdit;
  end;
end;

procedure TframeFuturaGrid.ConfirmarEdicao;
begin
  pFecharEditor(cxdPrecosCompra);
  pFecharEditor(cxdPrecosCusto);
  pFecharEditor(cxdPrecosCustoReal);
  pFecharEditor(cxdPrecos);
  pSincronizarCusto;
  pSincronizarTabelas;
end;

end.
