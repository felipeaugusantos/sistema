unit Reforma.View.Futura;

// Aba 3 "Formacao de Custo Futura". O dfm vem do tbsCustoFuturo da calculadora sem os eventos:
// eles sao ligados em pLigarEventos, como pSetaOnExitNovo faz no cadastro de produtos.
// Os controles tem nome que diz o que sao (lblIcmEntFut, lblDesF01PerFut...); os que a calculadora tinha como
// LabelNNN/PanelNN foram renomeados para isso. O sufixo Fut liga o controle ao equivalente da aba 1 (ver
// Reforma.View.Geometria).

interface

uses
  Winapi.Windows, System.Classes, Data.DB, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls, EditFocus, DBEditFocus, cxGroupBox,
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Host,
  Reforma.Simulacao.Modelo,
  Reforma.View.Validacao, Reforma.View.Geometria, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Mask;

type
  TframeFutura = class(TFrame)
    pnlConteudoFut: TPanel;
    FlwPnlTabelasFut: TFlowPanel;
    pnlTitulosTabelasFut: TPanel;
    lblTitMarBr1Fut: TLabel;
    lblTitComTb1Fut: TLabel;
    lblTitPreVe1Fut: TLabel;
    lblCusVenFut: TLabel;
    lblIBSFut: TLabel;
    lblISFut: TLabel;
    lblPreCliFut: TLabel;
    lblCBSFut: TLabel;
    gpbTabPre01Fut: TcxGroupBox;
    lblMarBr1: TLabel;
    lblPerComTb1: TLabel;
    lblCbsPer1: TLabel;
    lblIBSPer1: TLabel;
    lblISPer1: TLabel;
    dbeComTb1Fut: TDBEditFocus;
    dbeMarBr1Fut: TDBEditFocus;
    dbePreVe1Fut: TDBEditFocus;
    edtCusVen1Fut: TEditFocus;
    dbeCBS1Fut: TDBEditFocus;
    dbeIS1Fut: TDBEditFocus;
    dbeIBS1Fut: TDBEditFocus;
    dbePreCl1Fut: TDBEditFocus;
    gpbTabPre02Fut: TcxGroupBox;
    lblMarBr2: TLabel;
    lblPerComTb2: TLabel;
    lblCbsPer2: TLabel;
    lblIBSPer2: TLabel;
    lblISPer2: TLabel;
    dbeComTb2Fut: TDBEditFocus;
    dbeMarBr2Fut: TDBEditFocus;
    dbePreVe2Fut: TDBEditFocus;
    edtCusVen2Fut: TEditFocus;
    dbeCBS2Fut: TDBEditFocus;
    dbeIS2Fut: TDBEditFocus;
    dbeIBS2Fut: TDBEditFocus;
    dbePreCl2Fut: TDBEditFocus;
    gpbTabPre03Fut: TcxGroupBox;
    lblMarBr3: TLabel;
    lblPerComTb3: TLabel;
    lblCbsPer3: TLabel;
    lblIBSPer3: TLabel;
    lblISPer3: TLabel;
    dbeComTb3Fut: TDBEditFocus;
    dbeMarBr3Fut: TDBEditFocus;
    dbePreVe3Fut: TDBEditFocus;
    edtCusVen3Fut: TEditFocus;
    dbeCBS3Fut: TDBEditFocus;
    dbeIS3Fut: TDBEditFocus;
    dbeIBS3Fut: TDBEditFocus;
    dbePreCl3Fut: TDBEditFocus;
    gpbTabPre04Fut: TcxGroupBox;
    lblMarBr4: TLabel;
    lblPerComTb4: TLabel;
    lblCbsPer4: TLabel;
    lblIBSPer4: TLabel;
    lblISPer4: TLabel;
    dbeComTb4Fut: TDBEditFocus;
    dbeMarBr4Fut: TDBEditFocus;
    dbePreVe4Fut: TDBEditFocus;
    edtCusVen4Fut: TEditFocus;
    dbeCBS4Fut: TDBEditFocus;
    dbeIS4Fut: TDBEditFocus;
    dbeIBS4Fut: TDBEditFocus;
    dbePreCl4Fut: TDBEditFocus;
    gpbTabPre05Fut: TcxGroupBox;
    lblMarBr5: TLabel;
    lblPerComTb5: TLabel;
    lblCbsPer5: TLabel;
    lblIBSPer5: TLabel;
    lblISPer5: TLabel;
    dbeComTb5Fut: TDBEditFocus;
    dbeMarBr5Fut: TDBEditFocus;
    dbePreVe5Fut: TDBEditFocus;
    edtCusVen5Fut: TEditFocus;
    dbeCBS5Fut: TDBEditFocus;
    dbeIS5Fut: TDBEditFocus;
    dbeIBS5Fut: TDBEditFocus;
    dbePreCl5Fut: TDBEditFocus;
    gpbTabPre06Fut: TcxGroupBox;
    lblMarBr6: TLabel;
    lblPerComTb6: TLabel;
    lblCbsPer6: TLabel;
    lblIBSPer6: TLabel;
    lblISPer6: TLabel;
    dbeComTb6Fut: TDBEditFocus;
    dbeMarBr6Fut: TDBEditFocus;
    dbePreVe6Fut: TDBEditFocus;
    edtCusVen6Fut: TEditFocus;
    dbeCBS6Fut: TDBEditFocus;
    dbeIS6Fut: TDBEditFocus;
    dbeIBS6Fut: TDBEditFocus;
    dbePreCl6Fut: TDBEditFocus;
    gpbTabPre07Fut: TcxGroupBox;
    lblMarBr7: TLabel;
    lblPerComTb7: TLabel;
    lblCbsPer7: TLabel;
    lblIBSPer7: TLabel;
    lblISPer7: TLabel;
    dbeComTb7Fut: TDBEditFocus;
    dbeMarBr7Fut: TDBEditFocus;
    dbePreVe7Fut: TDBEditFocus;
    edtCusVen7Fut: TEditFocus;
    dbeCBS7Fut: TDBEditFocus;
    dbeIS7Fut: TDBEditFocus;
    dbeIBS7Fut: TDBEditFocus;
    dbePreCl7Fut: TDBEditFocus;
    pnlEspacadorTabelasFut: TPanel;
    pnlPrecosContainerFut: TPanel;
    lblPreComFut: TLabel;
    lblDesF01Fut: TLabel;
    lblDesF01PerFut: TLabel;
    lblDesF02Fut: TLabel;
    lblDesF02PerFut: TLabel;
    lblDesF03Fut: TLabel;
    lblDesF03PerFut: TLabel;
    lblDesF04Fut: TLabel;
    lblDesF04PerFut: TLabel;
    lblDesF05Fut: TLabel;
    lblDesF05PerFut: TLabel;
    lblDesF06Fut: TLabel;
    lblIcmEntFut: TLabel;
    lblIcmEntPerFut: TLabel;
    lblIpiEntFut: TLabel;
    lblIpiEntPerFut: TLabel;
    lblFreEntFut: TLabel;
    lblFreEntPerFut: TLabel;
    lblAcrFinFut: TLabel;
    lblAcrFinPerFut: TLabel;
    lblSubstiFut: TLabel;
    lblSubstiPerFut: TLabel;
    lblPreCusFut: TLabel;
    lblValFreFut: TLabel;
    lblDesAdiFut: TLabel;
    lblDesAdiPerFut: TLabel;
    lblDesF06PerFut: TLabel;
    lblComLiqFut: TLabel;
    lblTabPreFut: TLabel;
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
    dbeAcrFinFut: TDBEditFocus;
    dbeSubstiFut: TDBEditFocus;
    dbePreCusFut: TDBEditFocus;
    dbeValFreFut: TDBEditFocus;
    dbeDesAdbFut: TDBEditFocus;
    edtComLiqFut: TEditFocus;
    chkPreDolFut: TDBCheckBox;
    pnlCamposSuframaFut: TPanel;
    lblTCIFFut: TLabel;
    lblTSFut: TLabel;
    lblDePiCoFut: TLabel;
    lblDeICMSFut: TLabel;
    lblFatRegFut: TLabel;
    lblTCIFPerFut: TLabel;
    lblTSPerFut: TLabel;
    lblDePiCoPerFut: TLabel;
    lblDeICMSPerFut: TLabel;
    lblFatRegPerFut: TLabel;
    dbeTCIFFut: TDBEditFocus;
    dbeTSFut: TDBEditFocus;
    dbeDePiCoFut: TDBEditFocus;
    dbeDeICMSFut: TDBEditFocus;
    dbeFatRegFut: TDBEditFocus;
    pnlCusRealFut: TPanel;
    lblOutValFut: TLabel;
    lblIcmSaiFut: TLabel;
    lblDesOpeFut: TLabel;
    lblCusReaTitFut: TLabel;
    lblIcmSaiPerFut: TLabel;
    lblDesOpePerFut: TLabel;
    dbeOutValFut: TDBEditFocus;
    dbeIcmSaiFut: TDBEditFocus;
    dbeDesOpeFut: TDBEditFocus;
    edtCusReaFut: TEditFocus;
    dtsCalculadora: TDataSource;
  strict protected
    FHost: IReformaHost;
    FSimulacao: TSimulacaoReforma;
    FValidador: TValidadorPrecos;
    FConfiguracao: TConfiguracaoReforma;
    // Operador sem EDTCUS: custo travado na alteracao, como na aba 1 (lido uma vez).
    FSemAcessoCusto: Boolean;
    FDolarVisivel: Boolean;
    FAlinhado: Boolean;
    FAssinatura: string;
    function fDbe(const Prefixo: string; const Tabela: Integer): TDBEditFocus;
    function fEdt(const Prefixo: string; const Tabela: Integer): TEditFocus;
    function fLbl(const Prefixo: string; const Tabela: Integer): TLabel;
    function fMascara(const Digitos: Integer): string;
    function fMontarControles: TControlesPrecos;
    procedure pConfigurar;
    procedure pCriarCamposDolar;
    function fDolarAtivo: Boolean;
    procedure pAtualizarDolar;
    procedure pAlinharTela;
    procedure pReempilharLinhas;
    procedure pLigarEventos;
    procedure pAjustarRotulos;
    procedure pAjustarPosicaoTabela(const Tabela: Integer);
    procedure pAtualizarTela(Sender: TObject);
    procedure pValidarPrecos(Sender: TObject);
    procedure pMargemEntrar(Sender: TObject);
    procedure pPrecoDolarClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    constructor Criar(AOwner: TComponent; const Host: IReformaHost;
      const Simulacao: TSimulacaoReforma);
    destructor Destroy; override;
    // pgcPrecosChange da calculadora ao entrar na aba 3.
    procedure Entrar;
    // Segue o estado de edicao do cadastro (habilita ou desabilita os campos).
    procedure AplicarEstado;
  end;

implementation

{$R *.dfm}

uses
  System.SysUtils, System.StrUtils,
  Reforma.Calculo.Formacao, Reforma.View.Estilo;

const
  TABELAS = QUANTIDADE_TABELAS_PRECO;

constructor TframeFutura.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  pConfigurar;
end;

constructor TframeFutura.Criar(AOwner: TComponent; const Host: IReformaHost;
  const Simulacao: TSimulacaoReforma);
begin
  FHost := Host;
  FSimulacao := Simulacao;
  Create(AOwner);
end;

destructor TframeFutura.Destroy;
begin
  if Assigned(FSimulacao) then
    FSimulacao.RemoverOuvinte(pAtualizarTela);
  FreeAndNil(FValidador);
  inherited Destroy;
end;


function TframeFutura.fDbe(const Prefixo: string; const Tabela: Integer): TDBEditFocus;
begin
  Result := FindComponent(Prefixo + IntToStr(Tabela) + 'Fut') as TDBEditFocus;
end;

function TframeFutura.fEdt(const Prefixo: string; const Tabela: Integer): TEditFocus;
begin
  Result := FindComponent(Prefixo + IntToStr(Tabela) + 'Fut') as TEditFocus;
end;

function TframeFutura.fLbl(const Prefixo: string; const Tabela: Integer): TLabel;
begin
  Result := FindComponent(Prefixo + IntToStr(Tabela)) as TLabel;
end;

// fMskDigitos do host: mascara com milhar e N casas.
function TframeFutura.fMascara(const Digitos: Integer): string;
begin
  if Digitos = 0 then
    Result := '#,##0.' + StringOfChar('0', 2)
  else
    Result := '#,##0.' + StringOfChar('0', Digitos);
end;

function TframeFutura.fMontarControles: TControlesPrecos;
var
  Tabela: Integer;
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

  for Tabela := 1 to TABELAS do
  begin
    Result.MargemBruta[Tabela] := fDbe('dbeMarBr', Tabela);
    Result.Comissao[Tabela] := fDbe('dbeComTb', Tabela);
    Result.PrecoVenda[Tabela] := fDbe('dbePreVe', Tabela);
    Result.PrecoCliente[Tabela] := fDbe('dbePreCl', Tabela);
  end;
end;

procedure TframeFutura.pConfigurar;
begin
  FConfiguracao := FHost.Configuracao;
  FSemAcessoCusto := not FHost.Acesso('EDTCUS');
  dtsCalculadora.DataSet := FSimulacao.Dados;
  // Com o desconto PIS/COFINS ligado (REFTRI-01, RF04) o Preco de Compra da aba 3 e o preco com desconto da aba 2;
  // editar refaz o preco de compra de tras para frente (TValidadorPrecos, grPrecoLiquido).
  if FSimulacao.UsaDescontoPisCofins then
    dbePreComFut.DataField := 'ITE_PRELIQ';
  FSimulacao.AdicionarOuvinte(pAtualizarTela);
  FValidador := TValidadorPrecos.Create(FHost, FSimulacao, fMontarControles);

  pLigarEventos;
  pAjustarRotulos;

  // FormShow do cadastro desabilita o flag: ele reflete o produto, nao e editado aqui.
  chkPreDolFut.Enabled := False;
  FDolarVisivel := fDolarAtivo;
  pCriarCamposDolar;
  pAlinharTela;
  pAtualizarDolar;
  pAcompanharCoresAba1(FHost, Self, ['Fut']);
  pTravarCamposDoProduto(Self, FSimulacao);
  AplicarEstado;
end;

procedure TframeFutura.pLigarEventos;
var
  Tabela: Integer;
  Controles: TControlesPrecos;
  Indice: Integer;
begin
  Controles := fMontarControles;

  // pSetaOnExitNovo (trecho Futura): todo campo digitavel valida na saida.
  Controles.PrecoCompra.OnExit := pValidarPrecos;
  for Indice := Low(Controles.Descontos) to High(Controles.Descontos) do
    Controles.Descontos[Indice].OnExit := pValidarPrecos;
  Controles.IcmsEntrada.OnExit := pValidarPrecos;
  Controles.IpiEntrada.OnExit := pValidarPrecos;
  Controles.FreteEntrada.OnExit := pValidarPrecos;
  Controles.ValorFrete.OnExit := pValidarPrecos;
  Controles.AcrescimoFinanceiro.OnExit := pValidarPrecos;
  Controles.Substituicao.OnExit := pValidarPrecos;
  Controles.DescontoAdicional.OnExit := pValidarPrecos;
  Controles.SuframaTcif.OnExit := pValidarPrecos;
  Controles.SuframaTs.OnExit := pValidarPrecos;
  Controles.SuframaPisCofins.OnExit := pValidarPrecos;
  Controles.SuframaIcms.OnExit := pValidarPrecos;
  Controles.SuframaFatorRegional.OnExit := pValidarPrecos;
  Controles.OutrosValores.OnExit := pValidarPrecos;
  Controles.IcmsSaida.OnExit := pValidarPrecos;
  Controles.DespesaOperacional.OnExit := pValidarPrecos;

  for Tabela := 1 to TABELAS do
  begin
    Controles.MargemBruta[Tabela].OnExit := pValidarPrecos;
    Controles.MargemBruta[Tabela].OnEnter := pMargemEntrar;
    Controles.Comissao[Tabela].OnExit := pValidarPrecos;
    Controles.PrecoVenda[Tabela].OnExit := pValidarPrecos;
    Controles.PrecoCliente[Tabela].OnExit := pValidarPrecos;
  end;

  chkPreDolFut.OnClick := pPrecoDolarClick;
end;

// pAjustaDolar do host: a linha US$ (rotulo + um campo por tabela) so aparece com cotacao e o flag
// visivel. Os campos nao existem no DFM: nascem aqui e a posicao vem do host em pAlinharComHost
// (edtDolarN / lblDolar1 sem o sufixo Fut).
procedure TframeFutura.pCriarCamposDolar;
var
  Tabela: Integer;
  Rotulo: TLabel;
  Campo: TEditFocus;
begin
  Rotulo := TLabel.Create(Self);
  Rotulo.Name := 'lblDolar1Fut';
  Rotulo.Parent := pnlTitulosTabelasFut;
  Rotulo.Alignment := taRightJustify;
  Rotulo.Caption := 'US$:';
  Rotulo.Transparent := True;
  Rotulo.Font.Assign(lblTitPreVe1Fut.Font);
  Rotulo.Visible := False;

  for Tabela := 1 to TABELAS do
  begin
    Campo := TEditFocus.Create(Self);
    Campo.Name := 'edtDolar' + IntToStr(Tabela) + 'Fut';
    Campo.Parent := FindComponent('gpbTabPre0' + IntToStr(Tabela) + 'Fut') as TcxGroupBox;
    Campo.Font.Assign(fDbe('dbePreVe', Tabela).Font);
    Campo.Ctl3D := fDbe('dbePreVe', Tabela).Ctl3D;
    Campo.Alignment := taLeftJustify;
    Campo.TabStop := False;
    Campo.ReadOnly := True;
    Campo.Enabled := False;
    // Tag 50 fica de fora do habilitar/desabilitar por estado, como no host.
    Campo.Tag := 50;
    Campo.Visible := False;
  end;
end;

// Mesma regra de pAjustaDolar do host: precisa do flag visivel e de cotacao.
function TframeFutura.fDolarAtivo: Boolean;
begin
  Result := chkPreDolFut.Visible and (FHost.CotacaoDolarVenda > 0);
end;

// Visibilidade e posicao da linha US$ ficam decididas na criacao (FDolarVisivel), como no cadastro;
// aqui so os valores acompanham a simulacao.
procedure TframeFutura.pAtualizarDolar;
var
  Tabela: Integer;
  Cotacao: Double;
  Rotulo: TLabel;
begin
  Rotulo := FindComponent('lblDolar1Fut') as TLabel;
  if Rotulo = nil then
    Exit;

  Rotulo.Visible := FDolarVisivel;
  Cotacao := FHost.CotacaoDolarVenda;

  for Tabela := 1 to TABELAS do
  begin
    fEdt('edtDolar', Tabela).Visible := FDolarVisivel;
    if FDolarVisivel and (Cotacao > 0) then
      fEdt('edtDolar', Tabela).Text := FormatFloat(fMascara(FConfiguracao.DecimaisUnitarios),
        FHost.TextoParaNumero(fDbe('dbePreVe', Tabela).Text) / Cotacao);
  end;
end;

// As posicoes sao calculadas uma vez, na criacao da aba (o cadastro ja definiu a visibilidade dos
// campos). Depois so voltam a ser calculadas se o layout do host tiver mudado de fato, o que a
// assinatura acusa; navegar entre as abas nao move nenhum controle.
procedure TframeFutura.pAlinharTela;
var
  Assinatura: string;
  Escondeu: Boolean;
begin
  Assinatura := fAssinaturaLayout(FHost);
  if FAlinhado and (Assinatura = FAssinatura) then
    Exit;

  // Com a aba na tela, esconde o conteudo enquanto reposiciona para nao mostrar os passos intermediarios.
  Escondeu := pnlConteudoFut.Showing;
  if Escondeu then
    pnlConteudoFut.Visible := False;
  try
    pAlinharComHost(Self, FHost);
    pReempilharLinhas;
  finally
    if Escondeu then
      pnlConteudoFut.Visible := True;
  end;

  FAssinatura := Assinatura;
  FAlinhado := True;
end;

// CFG_REFCIS desligado: o host esconde CBS, IBS, IS e Pr. Venda com Impostos na aba 1 e sobe esses
// controles (e encurta os grupos) para fechar o buraco, entao a posicao que ele informa nao serve
// para essas linhas. Aqui elas continuam visiveis: empilha tudo de novo, na ordem e no passo da
// aba 1, mantendo a distancia que cada rotulo tem do seu campo (no host ela varia de 5 a 7 px).
procedure TframeFutura.pReempilharLinhas;
type
  TLinha = record
    Campo: TControl;
    Titulo: TLabel;
    Percentual: TLabel;
    Ativa: Boolean;
    DistanciaTitulo: Integer;
    DistanciaPercentual: Integer;
  end;
var
  Tabela: Integer;
  Indice: Integer;
  Posicao: Integer;
  Passo: Integer;
  Linhas: array[1..9] of TLinha;
  Grupo: TcxGroupBox;
  Margem: TDBEditFocus;
  Comissao: TDBEditFocus;

  procedure pDefinir(const Linha: Integer; const Campo: TControl; const Titulo, Percentual: TLabel;
    const Ativa: Boolean);
  begin
    Linhas[Linha].Campo := Campo;
    Linhas[Linha].Titulo := Titulo;
    Linhas[Linha].Percentual := Percentual;
    Linhas[Linha].Ativa := Ativa;
    Linhas[Linha].DistanciaTitulo := 0;
    Linhas[Linha].DistanciaPercentual := 0;
    if Assigned(Titulo) then
      Linhas[Linha].DistanciaTitulo := Titulo.Top - Campo.Top;
    if Assigned(Percentual) then
      Linhas[Linha].DistanciaPercentual := Percentual.Top - Campo.Top;
  end;

  // Os rotulos de titulo existem so na tabela 1.
  function fTitulo(const Nome: string): TLabel;
  begin
    if Tabela = 1 then
      Result := FindComponent(Nome) as TLabel
    else
      Result := nil;
  end;

  function fPercentual(const Nome: string): TLabel;
  begin
    Result := FindComponent(Nome + IntToStr(Tabela)) as TLabel;
  end;

begin
  if FHost.ConfiguracaoBooleana('REFCIS') then
    Exit;

  for Tabela := 1 to TABELAS do
  begin
    Grupo := FindComponent('gpbTabPre0' + IntToStr(Tabela) + 'Fut') as TcxGroupBox;
    Margem := fDbe('dbeMarBr', Tabela);
    Comissao := fDbe('dbeComTb', Tabela);

    Passo := Comissao.Top - Margem.Top;
    if Passo <= 0 then
      Passo := Margem.Height;

    pDefinir(1, Margem, fTitulo('lblTitMarBr1Fut'), fPercentual('lblMarBr'), True);
    pDefinir(2, Comissao, fTitulo('lblTitComTb1Fut'), fPercentual('lblPerComTb'), Comissao.Visible);
    pDefinir(3, fDbe('dbePreVe', Tabela), fTitulo('lblTitPreVe1Fut'), nil, True);
    pDefinir(4, fEdt('edtCusVen', Tabela), fTitulo('lblCusVenFut'), nil, fEdt('edtCusVen', Tabela).Visible);
    pDefinir(5, fEdt('edtDolar', Tabela), fTitulo('lblDolar1Fut'), nil, FDolarVisivel);
    pDefinir(6, fDbe('dbeCBS', Tabela), fTitulo('lblCBSFut'), fPercentual('lblCbsPer'), True);
    pDefinir(7, fDbe('dbeIBS', Tabela), fTitulo('lblIBSFut'), fPercentual('lblIBSPer'), True);
    pDefinir(8, fDbe('dbeIS', Tabela), fTitulo('lblISFut'), fPercentual('lblISPer'), True);
    pDefinir(9, fDbe('dbePreCl', Tabela), fTitulo('lblPreCliFut'), nil, True);

    Posicao := Margem.Top;
    for Indice := Low(Linhas) to High(Linhas) do
      if Linhas[Indice].Ativa then
      begin
        Linhas[Indice].Campo.Top := Posicao;
        if Assigned(Linhas[Indice].Titulo) then
          Linhas[Indice].Titulo.Top := Posicao + Linhas[Indice].DistanciaTitulo;
        if Assigned(Linhas[Indice].Percentual) then
          Linhas[Indice].Percentual.Top := Posicao + Linhas[Indice].DistanciaPercentual;
        Posicao := Posicao + Passo;
      end;

    Grupo.Height := Posicao + 3;
  end;
end;

// pAjustaLabelsFutura e o trecho de FormShow/FormCreate que decide o que a aba mostra.
procedure TframeFutura.pAjustarRotulos;
var
  Tabela: Integer;
  MargemMarkup: string;
  Comissao: string;
  Suframa: Boolean;
begin
  MargemMarkup := FHost.ConfiguracaoTexto('MARMKP');
  Comissao := FHost.ConfiguracaoTexto('PCMPRO');

  lblOutValFut.Caption := FHost.ConfiguracaoTexto('DOVCPP') + ' (+):';
  lblDesAdiFut.Caption := FHost.ConfiguracaoTexto('DESADI') + ' (' + FHost.ConfiguracaoTexto('OPEADI') + '):';
  lblValFreFut.Caption := FHost.ConfiguracaoTexto('DESVFR') + ' (+):';

  if Pos(MargemMarkup, '1_5_') = 0 then
    lblTitMarBr1Fut.Caption := 'Markup:';

  if MargemMarkup = '4' then
    lblCusVenFut.Caption := 'IVA:';

  if Comissao <> '2' then
    lblTitComTb1Fut.Caption := FHost.ConfiguracaoTexto('TCOMTB') + ':';

  if Comissao = '1' then
  begin
    lblTitComTb1Fut.Visible := False;
    for Tabela := 1 to TABELAS do
    begin
      fDbe('dbeComTb', Tabela).Visible := False;
      fLbl('lblPerComTb', Tabela).Visible := False;
    end;
  end;

  if not (Pos(MargemMarkup, '_1_2') > 0) then
  begin
    lblCusVenFut.Visible := False;
    for Tabela := 1 to TABELAS do
      fEdt('edtCusVen', Tabela).Visible := False;
  end;

  chkPreDolFut.Visible := FHost.ConfiguracaoBooleana('COTDOR');

  Suframa := FHost.ConfiguracaoBooleana('SUFRAM') and (FHost.ConfiguracaoTexto('FRMCUS') = '4');
  pnlCamposSuframaFut.Visible := Suframa;
  if not Suframa then
    pnlCusRealFut.Left := pnlCamposSuframaFut.Left;

  // Os grupos nascem ocultos no DFM; so as tabelas ativas (TABPRC) aparecem.
  for Tabela := 1 to TABELAS do
  begin
    (FindComponent('gpbTabPre0' + IntToStr(Tabela) + 'Fut') as TcxGroupBox).Visible := FConfiguracao.TabelaAtiva[Tabela];
    pAjustarPosicaoTabela(Tabela);
  end;
end;

// pAjustaPosicaoFutura: empilha so os campos visiveis de cada tabela e ajusta a altura do grupo.
procedure TframeFutura.pAjustarPosicaoTabela(const Tabela: Integer);
type
  TLinha = record
    Campo: TControl;
    Titulo: TLabel;
    Percentual: TLabel;
  end;
var
  Linhas: array[1..8] of TLinha;
  Indice: Integer;
  PosicaoInicial: Integer;
  Diferenca: Integer;
  Grupo: TcxGroupBox;
  Comissao: TDBEditFocus;
  Margem: TDBEditFocus;

  procedure pDefinir(const Posicao: Integer; const Campo: TControl; const Titulo, Percentual: TLabel);
  begin
    Linhas[Posicao].Campo := Campo;
    Linhas[Posicao].Titulo := Titulo;
    Linhas[Posicao].Percentual := Percentual;
  end;

  // Os rotulos de titulo existem so na tabela 1, onde a calculadora passa Nil para as demais.
  function fTitulo(const Nome: string): TLabel;
  begin
    if Tabela = 1 then
      Result := FindComponent(Nome) as TLabel
    else
      Result := nil;
  end;

  function fPercentual(const Nome: string): TLabel;
  begin
    Result := FindComponent(Nome + IntToStr(Tabela)) as TLabel;
  end;

begin
  Grupo := FindComponent('gpbTabPre0' + IntToStr(Tabela) + 'Fut') as TcxGroupBox;
  Margem := fDbe('dbeMarBr', Tabela);
  Comissao := fDbe('dbeComTb', Tabela);

  pDefinir(1, Margem, fTitulo('lblTitMarBr1Fut'), fPercentual('lblMarBr'));
  pDefinir(2, Comissao, fTitulo('lblTitComTb1Fut'), fPercentual('lblPerComTb'));
  pDefinir(3, fDbe('dbePreVe', Tabela), fTitulo('lblTitPreVe1Fut'), nil);
  pDefinir(4, fEdt('edtCusVen', Tabela), fTitulo('lblCusVenFut'), nil);
  pDefinir(5, fDbe('dbeCBS', Tabela), fTitulo('lblCBSFut'), fPercentual('lblCbsPer'));
  pDefinir(6, fDbe('dbeIBS', Tabela), fTitulo('lblIBSFut'), fPercentual('lblIBSPer'));
  pDefinir(7, fDbe('dbeIS', Tabela), fTitulo('lblISFut'), fPercentual('lblISPer'));
  pDefinir(8, fDbe('dbePreCl', Tabela), fTitulo('lblPreCliFut'), nil);

  PosicaoInicial := Margem.Top;
  Diferenca := Comissao.Top - Margem.Top;

  for Indice := Low(Linhas) to High(Linhas) do
    if Linhas[Indice].Campo.Visible then
    begin
      Linhas[Indice].Campo.Top := PosicaoInicial;
      PosicaoInicial := PosicaoInicial + Diferenca;

      if Assigned(Linhas[Indice].Titulo) then
        Linhas[Indice].Titulo.Top := Linhas[Indice].Campo.Top + 8;
      if Assigned(Linhas[Indice].Percentual) then
        Linhas[Indice].Percentual.Top := Linhas[Indice].Campo.Top + 3;
    end;

  Grupo.Height := PosicaoInicial + 3;
end;

// Campos calculados que nao sao data-aware: refletem o ultimo calculo da simulacao.
procedure TframeFutura.pAtualizarTela(Sender: TObject);
var
  Tabela: Integer;
  Digitos: Integer;
begin
  Digitos := FConfiguracao.DecimaisUnitarios;

  edtComLiqFut.Text := FormatFloat(fMascara(Digitos), FSimulacao.Formacao.PrecoCompraLiquido);

  if FConfiguracao.MargemMarkup = 4 then
    edtCusReaFut.Text := FormatFloat(fMascara(4), FSimulacao.Formacao.CustoReal)
  else
    edtCusReaFut.Text := FormatFloat(fMascara(Digitos), FSimulacao.Formacao.CustoReal);

  for Tabela := 1 to TABELAS do
    fEdt('edtCusVen', Tabela).Text := FormatFloat(fMascara(Digitos), FSimulacao.Formacao.Tabelas[Tabela].CustoVenda);

  pAtualizarDolar;
end;

procedure TframeFutura.AplicarEstado;
var
  Editando: Boolean;
begin
  // Empresa que recebe os precos da matriz so consulta, como a aba 1 dela; sem EDTCUS o custo trava na alteracao.
  Editando := not FConfiguracao.PrecosDaMatriz and (FHost.Produto.Estado in [ecInclusao, ecAlteracao]);
  pAplicarEstadoEdicao(Self, Editando);
  if Editando and fCustoBloqueado(FHost, FSemAcessoCusto) then
    pBloquearCusto(fMontarControles);
end;

procedure TframeFutura.Entrar;
begin
  // Aliquotas e revalidacao ao abrir a aba nao sao edicao do usuario: nao marcam pendencia.
  FSimulacao.ExecutarSemMarcar(
    procedure
    begin
      FSimulacao.CarregarAliquotas;
      pAlinharTela;
      AplicarEstado;
      pValidarPrecos(dbePreComFut);
      pAtualizarDolar;
    end);
  pAcompanharCoresAba1(FHost, Self, ['Fut']);
end;

procedure TframeFutura.pValidarPrecos(Sender: TObject);
begin
  FValidador.Validar(Sender as TDBEditFocus);
end;

procedure TframeFutura.pMargemEntrar(Sender: TObject);
begin
  FSimulacao.DefinirFormatoMargem(StrToInt(Copy(TDBEditFocus(Sender).Name, 9, 1)), 8);
end;

procedure TframeFutura.pPrecoDolarClick(Sender: TObject);
begin
  if (FHost.TextoParaNumero(dbePreComFut.Text) <> 0) and FSimulacao.Dados.Active and
     (FSimulacao.Dados.State <> dsBrowse) then
    pValidarPrecos(dbePreComFut);
end;

end.