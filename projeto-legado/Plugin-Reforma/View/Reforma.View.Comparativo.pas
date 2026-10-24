unit Reforma.View.Comparativo;

// Aba 2 "Comparativo de Custos (2026/2027)". O dfm vem do tbsComparativoCustos da calculadora sem
// os eventos, ligados em pLigarEventos como o cadastro faz. Os nomes dos controles seguem a calculadora.
//
// Lado Novo: dataset da simulacao (dtsCalculadora), validado por TValidadorPrecos.
// Lado Atual: liga direto no TDataSource do produto no host (dtsIteGer) e a validacao e a do host.
//
// Modo conversao (REFTRI-03, CFG_REFCIS = 'S', com Consulta): consulta somente leitura do que a conversao fez com o
// produto. O lado Atual vira "Antes da Conversao" (ITEREO) e o Novo, "Apos Conversao" (ITEREF); a simulacao nao e
// exibida e nada e validado nem gravado. A aba nao acompanha a aba 1: mostra o registro da conversao.

interface

uses
  Winapi.Windows, System.Classes, Data.DB, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Graphics, EditFocus, DBEditFocus, cxGroupBox,
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Host,
  Reforma.Simulacao.Modelo,
  Reforma.Calculo.Formacao,
  Reforma.Repositorio.Conversao,
  Reforma.View.Validacao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Mask;

type
  TframeComparativo = class(TFrame)
    scrComparativoAtual: TScrollBox;
    pnlCalculoAtual: TPanel;
    shpCalculoAtual: TShape;
    pnlPrecoCompraAtual: TPanel;
    lblPreComAtual: TLabel;
    lblDesF01Atual: TLabel;
    lblDesF01PerAtual: TLabel;
    lblDesF02Atual: TLabel;
    lblDesF02PerAtual: TLabel;
    lblDesF03Atual: TLabel;
    lblDesF03PerAtual: TLabel;
    lblDesF04Atual: TLabel;
    lblDesF04PerAtual: TLabel;
    lblDesF05Atual: TLabel;
    lblDesF05PerAtual: TLabel;
    lblDesF06Atual: TLabel;
    lblDesF06PerAtual: TLabel;
    lblComLiqAtual: TLabel;
    lblIcmEntAtual: TLabel;
    lblIcmEntPerAtual: TLabel;
    lblIpiEntAtual: TLabel;
    lblIpiEntPerAtual: TLabel;
    lblFreEntAtual: TLabel;
    lblFreEntPerAtual: TLabel;
    lblAcrFinAtual: TLabel;
    lblAcrFinPerAtual: TLabel;
    lblSubstiAtual: TLabel;
    lblSubstiPerAtual: TLabel;
    lblPreCusAtual: TLabel;
    lblValFreAtual: TLabel;
    lblDesAdiAtual: TLabel;
    lblDesAdiPerAtual: TLabel;
    lblSubFedAtual: TLabel;
    lblSubFedPerAtual: TLabel;
    dbePrecomAtual: TDBEditFocus;
    dbeDesF01Atual: TDBEditFocus;
    dbeDesF02Atual: TDBEditFocus;
    dbeDesF03Atual: TDBEditFocus;
    dbeDesF04Atual: TDBEditFocus;
    dbeDesF05Atual: TDBEditFocus;
    dbeDesF06Atual: TDBEditFocus;
    edtComLiqAtual: TEditFocus;
    chkPreDolAtual: TDBCheckBox;
    dbeIcmEntAtual: TDBEditFocus;
    dbeIpiEntAtual: TDBEditFocus;
    dbeFreEntAtual: TDBEditFocus;
    dbeAcrFinAtual: TDBEditFocus;
    dbeSubstiAtual: TDBEditFocus;
    dbePreCusAtual: TDBEditFocus;
    dbeValFreAtual: TDBEditFocus;
    dbeDesAdbAtual: TDBEditFocus;
    dbeSubFedAtual: TDBEditFocus;
    pnlCamposSuframaAtual: TPanel;
    lblTCIFAtual: TLabel;
    lblTSAtual: TLabel;
    lblDEPICOAtual: TLabel;
    lblDEICMSAtual: TLabel;
    lblFatRegAtual: TLabel;
    lblTCIFPerAtual: TLabel;
    lblTSPerAtual: TLabel;
    lblDEPICOPerAtual: TLabel;
    lblDEICMSPerAtual: TLabel;
    lblFatRegPerAtual: TLabel;
    dbeTCIFAtual: TDBEditFocus;
    dbeTSAtual: TDBEditFocus;
    dbeDEPICOAtual: TDBEditFocus;
    dbeDEICMSAtual: TDBEditFocus;
    dbeFatRegAtual: TDBEditFocus;
    pnlOutValAtual: TPanel;
    lblOutValAtual: TLabel;
    lblIcmSaiAtual: TLabel;
    lblImpFedAtual: TLabel;
    lblDesOpeAtual: TLabel;
    lblCusReaTitAtual: TLabel;
    lblIcmSaiPerAtual: TLabel;
    lblImpFedPerAtual: TLabel;
    lblDesOpePerAtual: TLabel;
    dbeOutValAtual: TDBEditFocus;
    dbeIcmSaiAtual: TDBEditFocus;
    dbeImpFedAtual: TDBEditFocus;
    dbeDesOpeAtual: TDBEditFocus;
    edtCusReaAtual: TEditFocus;
    lblValDesOpeAtual: TLabel;
    edtValDesOpeAtual: TEditFocus;
    pnlTabela1Atual: TPanel;
    pnlTitulosTabelaAtual: TPanel;
    lblTitMarBr1Atual: TLabel;
    lblTitComTb1Atual: TLabel;
    lblTitPreVe1Atual: TLabel;
    lblDolar1Atual: TLabel;
    lblMarIde1Atual: TLabel;
    lblCusVenAtual: TLabel;
    cxgTabela1Atual: TcxGroupBox;
    lblMarPerAtual: TLabel;
    lblPerComAtual: TLabel;
    lblMarIde1PerAtual: TLabel;
    dbeComTb1Atual: TDBEditFocus;
    dbeMarBr1Atual: TDBEditFocus;
    dbePreVe1Atual: TDBEditFocus;
    edtDolar1Atual: TEditFocus;
    dbeMarIde1Atual: TDBEditFocus;
    edtCusVen1Atual: TEditFocus;
    scrComparativoNovo: TScrollBox;
    pnlCalculoNovo: TPanel;
    shpCalculoNovo: TShape;
    pnlPrecoCompraNovo: TPanel;
    lblPreComNovo: TLabel;
    lblDesF01Novo: TLabel;
    lblDesF01PerNovo: TLabel;
    lblDesF02Novo: TLabel;
    lblDesF02PerNovo: TLabel;
    lblDesF03Novo: TLabel;
    lblDesF03PerNovo: TLabel;
    lblDesF04Novo: TLabel;
    lblDesF04PerNovo: TLabel;
    lblDesF05Novo: TLabel;
    lblDesF05PerNovo: TLabel;
    lblDesF06Novo: TLabel;
    lblDesF06PerNovo: TLabel;
    lblComLiqNovo: TLabel;
    lblIcmEntNovo: TLabel;
    lblIcmEntPerNovo: TLabel;
    lblIpiEntNovo: TLabel;
    lblIpiEntPerNovo: TLabel;
    lblFreEntNovo: TLabel;
    lblFreEntPerNovo: TLabel;
    lblAcrFinNovo: TLabel;
    lblAcrFinPerNovo: TLabel;
    lblSubstiNovo: TLabel;
    lblSubstiPerNovo: TLabel;
    lblPreCusNovo: TLabel;
    lblValFreNovo: TLabel;
    lblDesAdiNovo: TLabel;
    lblDesAdiPerNovo: TLabel;
    dbePreComNovo: TDBEditFocus;
    dbeDesF01Novo: TDBEditFocus;
    dbeDesF02Novo: TDBEditFocus;
    dbeDesF03Novo: TDBEditFocus;
    dbeDesF04Novo: TDBEditFocus;
    dbeDesF05Novo: TDBEditFocus;
    dbeDesF06Novo: TDBEditFocus;
    edtComLiqNovo: TEditFocus;
    chkPreDolNovo: TDBCheckBox;
    dbeIcmEntNovo: TDBEditFocus;
    dbeIpiEntNovo: TDBEditFocus;
    dbeFreEntNovo: TDBEditFocus;
    dbeAcrFinNovo: TDBEditFocus;
    dbeSubstiNovo: TDBEditFocus;
    dbePreCusNovo: TDBEditFocus;
    dbeValFreNovo: TDBEditFocus;
    dbeDesAdbNovo: TDBEditFocus;
    lblDesPisNovo: TLabel;
    lblDesPisPctNovo: TLabel;
    lblPreLiqNovo: TLabel;
    dbeDesPisNovo: TDBEditFocus;
    dbePreLiqNovo: TDBEditFocus;
    pnlCamposSuframaNovo: TPanel;
    lblTCIFNovo: TLabel;
    lblTSNovo: TLabel;
    lblDEPICONovo: TLabel;
    lblDEICMSNovo: TLabel;
    lblFatRegNovo: TLabel;
    lblTCIFPerNovo: TLabel;
    lblTSPerNovo: TLabel;
    lblDEPICOPerNovo: TLabel;
    lblDEICMSPerNovo: TLabel;
    lblFatRegPerNovo: TLabel;
    dbeTCIFNovo: TDBEditFocus;
    dbeTSNovo: TDBEditFocus;
    dbeDEPICONovo: TDBEditFocus;
    dbeDEICMSNovo: TDBEditFocus;
    dbeFatRegNovo: TDBEditFocus;
    pnlOutValNovo: TPanel;
    lblOutValNovo: TLabel;
    lblIcmSaiNovo: TLabel;
    lblDesOpeNovo: TLabel;
    lblCusReaTitNovo: TLabel;
    lblIcmSaiPerNovo: TLabel;
    lblDesOpePerNovo: TLabel;
    dbeOutValNovo: TDBEditFocus;
    dbeIcmSaiNovo: TDBEditFocus;
    dbeDesOpeNovo: TDBEditFocus;
    edtCusReaNovo: TEditFocus;
    lblValDesOpeNovo: TLabel;
    edtValDesOpeNovo: TEditFocus;
    pnlTabela1Novo: TPanel;
    pnlTitulosTabelaNovo: TPanel;
    lblTitMarBr1Novo: TLabel;
    lblTitComTb1Novo: TLabel;
    lblTitPreVe1Novo: TLabel;
    lblIBSNovo: TLabel;
    lblISNovo: TLabel;
    lblPreCliNovo: TLabel;
    lblCBSNovo: TLabel;
    cxgTabela1Novo: TcxGroupBox;
    lblMarPerNovo: TLabel;
    lblPerComNovo: TLabel;
    lblCBSPerNovo: TLabel;
    lblIBSPerNovo: TLabel;
    lblISPerNovo: TLabel;
    dbeComTb1Novo: TDBEditFocus;
    dbeMarBr1Novo: TDBEditFocus;
    dbePreVe1Novo: TDBEditFocus;
    dbeCBSNovo: TDBEditFocus;
    dbeIBSNovo: TDBEditFocus;
    dbeISNovo: TDBEditFocus;
    dbePreCliNovo: TDBEditFocus;
    dtsIteGer: TDataSource;
    dtsCalculadora: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
  strict private
    type
      TLinhaPosicao = record
        Campo: TControl;
        Titulo: TLabel;
        Percentual: TLabel;
      end;
      // Le um campo numerico do lado Atual: do produto no host ou, no modo conversao, da ITEREO.
      TLeitorCampo = reference to function(const Campo: string): Double;
    var
        FHost: IReformaHost;
      FSimulacao: TSimulacaoReforma;
      FValidador: TValidadorPrecos;
      FConfiguracao: TConfiguracaoReforma;
      // Modo conversao: nil com CFG_REFCIS = 'N'. Quem cria e libera e o plugin.
      FConsulta: TConsultaConversao;
      // Calculados do lado Apos (custo liquido, custo real, preco cliente) pelo motor do plugin.
      FCalculo: ICalculoFormacao;
      // Operador sem EDTCUS: custo travado na alteracao, como na aba 1 (lido uma vez).
      FSemAcessoCusto: Boolean;
      // CFG_REDTAR: linha da Reducao TARE da tabela 1 nos dois lados (pCriarLinhaTare).
      FReducaoTare: Boolean;
      edtRedTarAtual: TEditFocus;
      edtRedTarNovo: TEditFocus;
      chkUsaTarAtual: TCheckBox;
      chkUsaTarNovo: TCheckBox;
    procedure pBloquearCustoAtual;
    procedure pCriarLinhaTare;
    procedure pAtualizarTare;
    function fMascara(const Digitos: Integer): string;
    function fControlesNovo: TControlesPrecos;
    function fEntradaCusto(const Ler: TLeitorCampo; const ConverterMoeda: Boolean): TCustoEntrada;
    procedure pConfigurar;
    procedure pConfigurarConversao;
    procedure pLigarFonteAtual;
    procedure pLigarEventos;
    procedure pAjustarRotulos;
    procedure pAjustarDescontoPisCofins;
    procedure pAjustarPosicoes;
    procedure pAjustarBarra(const Caixa: TScrollBox);
    procedure pCaixaRedimensionada(Sender: TObject);
    procedure pEmpilhar(const Linhas: array of TLinhaPosicao; const Grupo: TcxGroupBox);
    procedure pAtualizarNovo(Sender: TObject);
    procedure pAtualizarAtual;
    procedure pLimparCalculadosAtual;
    procedure pExibirCalculadosAtual(const Ler: TLeitorCampo; const ConverterMoeda: Boolean);
    procedure pAtualizarAntes;
    procedure pAtualizarApos;
    procedure pValidarNovo(Sender: TObject);
    procedure pValidarAtual(Sender: TObject);
    procedure pMargemNovoEntrar(Sender: TObject);
    procedure pPrecoClienteTecla(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pPrecoDolarNovoClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    // Consulta: so no modo conversao (CFG_REFCIS = 'S'); nil mantem o comparativo com a simulacao.
    constructor Criar(AOwner: TComponent; const Host: IReformaHost;
      const Simulacao: TSimulacaoReforma; const Consulta: TConsultaConversao = nil);
    destructor Destroy; override;
    // pgcPrecosChange da calculadora ao entrar na aba 2.
    procedure Entrar;
    // O host avisa quando o produto muda na aba 1 ou o estado de edicao muda.
    procedure AtualizarAtual;
    // Segue o estado de edicao do cadastro (habilita ou desabilita os campos).
    procedure AplicarEstado;
  end;

implementation

{$R *.dfm}

uses
  System.SysUtils, System.StrUtils, System.Math,
  Reforma.Calculo.Modelo,
  Reforma.Calculo.CustoVenda,
  Reforma.View.Estilo;

constructor TframeComparativo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  pConfigurar;
end;

constructor TframeComparativo.Criar(AOwner: TComponent; const Host: IReformaHost;
  const Simulacao: TSimulacaoReforma; const Consulta: TConsultaConversao);
begin
  FHost := Host;
  FSimulacao := Simulacao;
  FConsulta := Consulta;
  Create(AOwner);
end;

destructor TframeComparativo.Destroy;
begin
  if Assigned(FSimulacao) then
    FSimulacao.RemoverOuvinte(pAtualizarNovo);
  FreeAndNil(FValidador);
  inherited Destroy;
end;


// fMskDigitos do host: mascara com milhar e N casas.
function TframeComparativo.fMascara(const Digitos: Integer): string;
begin
  if Digitos = 0 then
    Result := '#,##0.' + StringOfChar('0', 2)
  else
    Result := '#,##0.' + StringOfChar('0', Digitos);
end;

function TframeComparativo.fControlesNovo: TControlesPrecos;
begin
  FillChar(Result, SizeOf(Result), 0);

  Result.PrecoCompra := dbePreComNovo;
  Result.Descontos[1] := dbeDesF01Novo;
  Result.Descontos[2] := dbeDesF02Novo;
  Result.Descontos[3] := dbeDesF03Novo;
  Result.Descontos[4] := dbeDesF04Novo;
  Result.Descontos[5] := dbeDesF05Novo;
  Result.Descontos[6] := dbeDesF06Novo;
  Result.IcmsEntrada := dbeIcmEntNovo;
  Result.IpiEntrada := dbeIpiEntNovo;
  Result.FreteEntrada := dbeFreEntNovo;
  Result.ValorFrete := dbeValFreNovo;
  Result.AcrescimoFinanceiro := dbeAcrFinNovo;
  Result.Substituicao := dbeSubstiNovo;
  Result.DescontoAdicional := dbeDesAdbNovo;
  Result.SuframaTcif := dbeTCIFNovo;
  Result.SuframaTs := dbeTSNovo;
  Result.SuframaPisCofins := dbeDEPICONovo;
  Result.SuframaIcms := dbeDEICMSNovo;
  Result.SuframaFatorRegional := dbeFatRegNovo;
  Result.OutrosValores := dbeOutValNovo;
  Result.IcmsSaida := dbeIcmSaiNovo;
  Result.DespesaOperacional := dbeDesOpeNovo;
  Result.DescontoPisCofins := dbeDesPisNovo;
  Result.PainelSuframa := pnlCamposSuframaNovo;
  Result.RetemFocoNoPrecoCliente := True;

  // A aba 2 so tem a tabela 1.
  Result.MargemBruta[1] := dbeMarBr1Novo;
  Result.Comissao[1] := dbeComTb1Novo;
  Result.PrecoVenda[1] := dbePreVe1Novo;
  Result.PrecoCliente[1] := dbePreCliNovo;
end;

procedure TframeComparativo.pConfigurar;
begin
  FConfiguracao := FHost.Configuracao;
  if Assigned(FConsulta) then
    pConfigurarConversao
  else
  begin
    dtsCalculadora.DataSet := FSimulacao.Dados;
    FSimulacao.AdicionarOuvinte(pAtualizarNovo);
    FValidador := TValidadorPrecos.Create(FHost, FSimulacao, fControlesNovo);

    pLigarFonteAtual;
    pLigarEventos;
    FSemAcessoCusto := not FHost.Acesso('EDTCUS');
  end;
  pAjustarRotulos;
  FReducaoTare := fReducaoTareAtiva(FHost);
  if FReducaoTare then
    pCriarLinhaTare;
  pAcompanharCoresAba1(FHost, Self, ['Atual', 'Novo']);

  // Sem o direito PROTABPR (com CFG_VISABA) so a composicao do custo aparece (teste de 2026-10-16). O valor (R$) da
  // despesa operacional vem do preco de venda da tabela 1: some junto.
  if fTabelasOcultas(FHost) then
  begin
    pnlTabela1Atual.Visible := False;
    pnlTabela1Novo.Visible := False;
    lblValDesOpeAtual.Visible := False;
    edtValDesOpeAtual.Visible := False;
    lblValDesOpeNovo.Visible := False;
    edtValDesOpeNovo.Visible := False;
  end;

  scrComparativoAtual.AutoScroll := False;
  scrComparativoNovo.AutoScroll := False;
  scrComparativoAtual.OnResize := pCaixaRedimensionada;
  scrComparativoNovo.OnResize := pCaixaRedimensionada;
  pCaixaRedimensionada(scrComparativoAtual);
  pCaixaRedimensionada(scrComparativoNovo);
  // FormShow do cadastro desabilita os flags: refletem o produto, nao sao editados aqui.
  chkPreDolAtual.Enabled := False;
  chkPreDolNovo.Enabled := False;
  pTravarCamposDoProduto(Self, FSimulacao);
  AplicarEstado;
end;

// Modo conversao: os controles do lado Atual ficam no dtsIteGer do dfm, agora sobre a ITEREO, e os do Novo no
// dtsCalculadora, sobre a ITEREF. Sem eventos de validacao, sem validador e sem ouvinte da simulacao: nada e editavel.
procedure TframeComparativo.pConfigurarConversao;
var
  Indice: Integer;
  Componente: TComponent;
begin
  FCalculo := TCalculoFormacao.Create(FHost);

  Label2.Caption := 'Antes da Convers'#227'o';
  Label1.Caption := 'Ap'#243's Convers'#227'o';

  // Margem Ideal (ITE_MARID1) nao faz parte da ITEREO: sem fonte antes de ligar o dataset, senao o VCL acusa campo
  // inexistente. pAjustarRotulos nao a religa neste modo.
  dbeMarIde1Atual.DataSource := nil;
  dbeMarIde1Atual.Visible := False;
  lblMarIde1Atual.Visible := False;
  lblMarIde1PerAtual.Visible := False;

  // Valor (R$) da despesa operacional: so antes da conversao (teste de 2026-10-15).
  lblValDesOpeAtual.Visible := False;
  edtValDesOpeAtual.Visible := False;
  lblValDesOpeNovo.Visible := False;
  edtValDesOpeNovo.Visible := False;

  dtsIteGer.DataSet := FConsulta.Antes;
  dtsCalculadora.DataSet := FConsulta.Apos;

  for Indice := 0 to ComponentCount - 1 do
  begin
    Componente := Components[Indice];
    if Componente is TDBEditFocus then
      TDBEditFocus(Componente).ReadOnly := True
    else if Componente is TEditFocus then
      TEditFocus(Componente).ReadOnly := True;
  end;
end;

// Os controles do lado Atual apontam no dfm para dtsIteGer; aqui passam para a fonte do host.
procedure TframeComparativo.pLigarFonteAtual;
var
  Indice: Integer;
  Componente: TComponent;
  Fonte: TDataSource;
begin
  Fonte := FHost.Produto.FonteDados;

  for Indice := 0 to ComponentCount - 1 do
  begin
    Componente := Components[Indice];
    if (Componente is TDBEditFocus) and (TDBEditFocus(Componente).DataSource = dtsIteGer) then
      TDBEditFocus(Componente).DataSource := Fonte
    else if (Componente is TDBCheckBox) and (TDBCheckBox(Componente).DataSource = dtsIteGer) then
      TDBCheckBox(Componente).DataSource := Fonte;
  end;
end;

procedure TframeComparativo.pLigarEventos;
var
  Indice: Integer;
  Componente: TComponent;
  Controles: TControlesPrecos;
begin
  // Lado Atual: todo campo digitavel valida pelo host na saida (pValidarPrecos do cadastro).
  for Indice := 0 to ComponentCount - 1 do
  begin
    Componente := Components[Indice];
    if (Componente is TDBEditFocus) and (TDBEditFocus(Componente).DataSource <> dtsCalculadora) and
       (TDBEditFocus(Componente).DataField <> '') and (not TDBEditFocus(Componente).ReadOnly) then
      TDBEditFocus(Componente).OnExit := pValidarAtual;
  end;

  // pSetaOnExitNovo: lado Novo valida pelo motor do plugin.
  Controles := fControlesNovo;
  Controles.PrecoCompra.OnExit := pValidarNovo;
  for Indice := Low(Controles.Descontos) to High(Controles.Descontos) do
    Controles.Descontos[Indice].OnExit := pValidarNovo;
  Controles.IcmsEntrada.OnExit := pValidarNovo;
  Controles.IpiEntrada.OnExit := pValidarNovo;
  Controles.FreteEntrada.OnExit := pValidarNovo;
  Controles.ValorFrete.OnExit := pValidarNovo;
  Controles.AcrescimoFinanceiro.OnExit := pValidarNovo;
  Controles.Substituicao.OnExit := pValidarNovo;
  Controles.DescontoAdicional.OnExit := pValidarNovo;
  Controles.SuframaTcif.OnExit := pValidarNovo;
  Controles.SuframaTs.OnExit := pValidarNovo;
  Controles.SuframaPisCofins.OnExit := pValidarNovo;
  Controles.SuframaIcms.OnExit := pValidarNovo;
  Controles.SuframaFatorRegional.OnExit := pValidarNovo;
  Controles.OutrosValores.OnExit := pValidarNovo;
  Controles.IcmsSaida.OnExit := pValidarNovo;
  Controles.DespesaOperacional.OnExit := pValidarNovo;
  Controles.DescontoPisCofins.OnExit := pValidarNovo;
  Controles.MargemBruta[1].OnExit := pValidarNovo;
  Controles.MargemBruta[1].OnEnter := pMargemNovoEntrar;
  Controles.Comissao[1].OnExit := pValidarNovo;
  Controles.PrecoVenda[1].OnExit := pValidarNovo;
  Controles.PrecoCliente[1].OnExit := pValidarNovo;
  Controles.PrecoCliente[1].OnKeyDown := pPrecoClienteTecla;

  chkPreDolNovo.OnClick := pPrecoDolarNovoClick;
end;

// pCriaComparativoPrecos: rotulos e visibilidade que dependem das configuracoes.
procedure TframeComparativo.pAjustarRotulos;
var
  MargemMarkup: string;
  Comissao: string;
  Suframa: Boolean;
begin
  MargemMarkup := FHost.ConfiguracaoTexto('MARMKP');
  Comissao := FHost.ConfiguracaoTexto('PCMPRO');

  lblOutValAtual.Caption := FHost.ConfiguracaoTexto('DOVCPP') + ' (+):';
  lblDesAdiAtual.Caption := FHost.ConfiguracaoTexto('DESADI') + ' (' + FHost.ConfiguracaoTexto('OPEADI') + '):';
  lblOutValNovo.Caption := FHost.ConfiguracaoTexto('DOVCPP') + ' (+):';
  lblDesAdiNovo.Caption := FHost.ConfiguracaoTexto('DESADI') + ' (' + FHost.ConfiguracaoTexto('OPEADI') + '):';

  lblValFreAtual.Caption := FHost.ConfiguracaoTexto('DESVFR') + ' (+):';
  lblValFreNovo.Caption := FHost.ConfiguracaoTexto('DESVFR') + ' (+):';

  if Pos(MargemMarkup, '1_5_') = 0 then
  begin
    lblTitMarBr1Atual.Caption := 'Markup:';
    lblTitMarBr1Novo.Caption := 'Markup:';
  end;

  if MargemMarkup = '4' then
  begin
    lblCusReaTitAtual.Caption := 'IVA:';
    lblCusReaTitNovo.Caption := 'IVA:';
  end;

  if Comissao <> '2' then
  begin
    lblTitComTb1Atual.Caption := FHost.ConfiguracaoTexto('TCOMTB') + ':';
    lblTitComTb1Novo.Caption := FHost.ConfiguracaoTexto('TCOMTB') + ':';
  end;

  if Comissao = '1' then
  begin
    lblTitComTb1Atual.Visible := False;
    lblTitComTb1Novo.Visible := False;

    dbeComTb1Atual.Visible := False;
    dbeComTb1Novo.Visible := False;

    lblPerComAtual.Visible := False;
    lblPerComNovo.Visible := False;

    // Sem comissao, a margem ideal ocupa o lugar dela no lado Atual. No modo conversao ela nao existe (REFTRI-03).
    if FHost.ConfiguracaoBooleana('MARIDE') and not Assigned(FConsulta) then
    begin
      lblMarIde1Atual.Visible := True;
      lblMarIde1PerAtual.Visible := True;
      dbeMarIde1Atual.Visible := True;
    end;
  end;

  if not (Pos(MargemMarkup, '_1_2') > 0) then
  begin
    edtCusVen1Atual.Visible := False;
    lblCusVenAtual.Visible := False;
  end;

  chkPreDolAtual.Visible := FHost.ConfiguracaoBooleana('COTDOR');
  chkPreDolNovo.Visible := FHost.ConfiguracaoBooleana('COTDOR');

  Suframa := FHost.ConfiguracaoBooleana('SUFRAM') and (FHost.ConfiguracaoTexto('FRMCUS') = '4');
  pnlCamposSuframaAtual.Visible := Suframa;
  pnlCamposSuframaNovo.Visible := Suframa;

  pAjustarDescontoPisCofins;
  pAjustarPosicoes;
end;

// REFTRI-01 (RF01/RF02): com CFG_REFCIS = 'N' o bloco Novo mostra, logo abaixo do Preco de Compra, o Desconto
// PIS/COFINS 2027 e o Preco Liquido com Desconto. As linhas de baixo descem duas posicoes; o lado Atual fica como
// esta, mesmo sem emparelhar com o Novo (decisao do usuario). Com 'S' os campos ficam ocultos e nada se move. Roda
// uma vez, na criacao da aba.
procedure TframeComparativo.pAjustarDescontoPisCofins;

  procedure pDescer(const Painel: TPanel; const Topo, Deslocamento: Integer; const Exceto: array of TControl);
  var
    Indice: Integer;
    Controle: TControl;
    Outro: TControl;
    Ignorar: Boolean;
  begin
    for Indice := 0 to Painel.ControlCount - 1 do
    begin
      Controle := Painel.Controls[Indice];
      Ignorar := False;
      for Outro in Exceto do
        Ignorar := Ignorar or (Controle = Outro);
      if not Ignorar and (Controle.Top >= Topo) then
        Controle.Top := Controle.Top + Deslocamento;
    end;
    Painel.Height := Painel.Height + Deslocamento;
  end;

var
  Deslocamento: Integer;
begin
  if not FSimulacao.UsaDescontoPisCofins then
    Exit;

  // Duas linhas novas, com o mesmo passo das linhas do bloco.
  Deslocamento := 2 * (dbeDesF01Novo.Top - dbePreComNovo.Top);

  pDescer(pnlPrecoCompraNovo, dbeDesF01Novo.Top, Deslocamento,
    [lblDesPisNovo, dbeDesPisNovo, lblDesPisPctNovo, lblPreLiqNovo, dbePreLiqNovo]);

  lblDesPisNovo.Visible := True;
  dbeDesPisNovo.Visible := True;
  lblDesPisPctNovo.Visible := True;
  lblPreLiqNovo.Visible := True;
  dbePreLiqNovo.Visible := True;
  // Na tabulacao o desconto vem logo depois do preco de compra.
  dbeDesPisNovo.TabOrder := dbePreComNovo.TabOrder + 1;
end;

// pAjustaPosicaoComparativoAtual / Novo: empilha so os campos visiveis e ajusta a altura do grupo.
procedure TframeComparativo.pEmpilhar(const Linhas: array of TLinhaPosicao; const Grupo: TcxGroupBox);
var
  Indice: Integer;
  PosicaoInicial: Integer;
  Diferenca: Integer;
begin
  PosicaoInicial := Linhas[0].Campo.Top;
  Diferenca := Linhas[1].Campo.Top - Linhas[0].Campo.Top;

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

procedure TframeComparativo.pAjustarPosicoes;

  function fLinha(const Campo: TControl; const Titulo, Percentual: TLabel): TLinhaPosicao;
  begin
    Result.Campo := Campo;
    Result.Titulo := Titulo;
    Result.Percentual := Percentual;
  end;

begin
  pEmpilhar([
    fLinha(dbeMarBr1Atual, lblTitMarBr1Atual, lblMarPerAtual),
    fLinha(dbeComTb1Atual, lblTitComTb1Atual, lblPerComAtual),
    fLinha(dbePreVe1Atual, lblTitPreVe1Atual, nil),
    fLinha(edtCusVen1Atual, lblCusVenAtual, nil),
    fLinha(edtDolar1Atual, lblDolar1Atual, nil),
    fLinha(dbeMarIde1Atual, lblMarIde1Atual, lblMarIde1PerAtual)], cxgTabela1Atual);

  pEmpilhar([
    fLinha(dbeMarBr1Novo, lblTitMarBr1Novo, lblMarPerNovo),
    fLinha(dbeComTb1Novo, lblTitComTb1Novo, lblPerComNovo),
    fLinha(dbePreVe1Novo, lblTitPreVe1Novo, nil),
    fLinha(dbeCBSNovo, lblCBSNovo, lblCBSPerNovo),
    fLinha(dbeIBSNovo, lblIBSNovo, lblIBSPerNovo),
    fLinha(dbeISNovo, lblISNovo, lblISPerNovo),
    fLinha(dbePreCliNovo, lblPreCliNovo, nil)], cxgTabela1Novo);
end;

// Campos calculados do lado Novo, que nao sao data-aware.
procedure TframeComparativo.pAtualizarNovo(Sender: TObject);
var
  Digitos: Integer;
begin
  Digitos := FConfiguracao.DecimaisUnitarios;

  edtComLiqNovo.Text := FormatFloat(fMascara(Digitos), FSimulacao.Formacao.PrecoCompraLiquido);

  if FConfiguracao.MargemMarkup = 4 then
    edtCusReaNovo.Text := FormatFloat(fMascara(4), FSimulacao.Formacao.CustoReal)
  else
    edtCusReaNovo.Text := FormatFloat(fMascara(Digitos), FSimulacao.Formacao.CustoReal);

  // Valor (R$) da despesa operacional sobre o preco de venda da tabela 1, como a calculadora mostrava.
  edtValDesOpeNovo.Text := FormatFloat(fMascara(Digitos),
    FSimulacao.Formacao.Tabelas[1].PrecoVenda * FSimulacao.Formacao.DespesaOperacional / 100);
  pAtualizarTare;
end;

// CFG_REDTAR (teste de 2026-10-15): a aba 1 mostra a Reducao TARE no custo real e o "Utiliza" por tabela. A aba 2 mostra
// os dois da tabela 1, nos lados Atual e Novo, somente leitura: a TARE e da aba 1 e a simulacao nao a muda (a conta do
// lado Novo ja a aplicava, TCalculoFormacao.AplicarTare). Uma linha a mais, abaixo do custo real.
procedure TframeComparativo.pCriarLinhaTare;

  procedure pCriar(const Painel: TPanel; const Titulo: TLabel; const Modelo: TEditFocus; const Percentual: TLabel;
    out Campo: TEditFocus; out Usa: TCheckBox);
  var
    Topo: Integer;
    Rotulo: TLabel;
    Porcento: TLabel;
  begin
    Topo := Modelo.Top + 22;

    Rotulo := TLabel.Create(Self);
    Rotulo.Parent := Painel;
    Rotulo.AutoSize := False;
    Rotulo.Alignment := taRightJustify;
    Rotulo.Font.Assign(Titulo.Font);
    Rotulo.SetBounds(Titulo.Left, Topo + 3, Titulo.Width, Titulo.Height);
    Rotulo.Caption := 'Redu'#231#227'o TARE:';

    Campo := TEditFocus.Create(Self);
    Campo.Parent := Painel;
    Campo.SetBounds(Modelo.Left, Topo, Modelo.Width, Modelo.Height);
    Campo.TabStop := False;
    Campo.Alignment := taRightJustify;
    Campo.ReadOnly := True;
    Campo.Enabled := False;

    Porcento := TLabel.Create(Self);
    Porcento.Parent := Painel;
    Porcento.Alignment := taRightJustify;
    Porcento.Font.Assign(Percentual.Font);
    Porcento.SetBounds(Percentual.Left, Topo + 4, Percentual.Width, Percentual.Height);
    Porcento.Caption := '%';

    Usa := TCheckBox.Create(Self);
    Usa.Parent := Painel;
    Usa.SetBounds(Percentual.Left + Percentual.Width + 8, Topo + 2, 140, 17);
    Usa.Caption := 'Utiliza na Tabela 1';
    Usa.TabStop := False;
    Usa.Enabled := False;

    Painel.Height := Painel.Height + 22;
  end;

begin
  pCriar(pnlOutValAtual, lblDesOpeAtual, edtCusReaAtual, lblDesOpePerAtual, edtRedTarAtual, chkUsaTarAtual);
  pCriar(pnlOutValNovo, lblDesOpeNovo, edtCusReaNovo, lblDesOpePerNovo, edtRedTarNovo, chkUsaTarNovo);
end;

// Percentual da tabela 1 (PRO_REDTAR, com ou sem o "Utiliza") e o "Utiliza" dela, lidos da aba 1. Exe anterior ao
// contrato 13 so informa a reducao aplicada.
procedure TframeComparativo.pAtualizarTare;
var
  Percentual: Double;
  Reducao: Double;
  Usa: Boolean;
begin
  if not FReducaoTare or not Assigned(edtRedTarAtual) then
    Exit;

  Reducao := FHost.Produto.ValorNumerico(CAMPO_REDUCAO_TARE + '1');
  Percentual := FHost.Produto.ValorNumerico(CAMPO_PERCENTUAL_TARE + '1');
  if Percentual = 0 then
    Percentual := Reducao;
  Usa := (FHost.Produto.ValorNumerico(CAMPO_USA_TARE + '1') <> 0) or (Reducao <> 0);

  edtRedTarAtual.Text := FormatFloat('#,##0.00', Percentual);
  edtRedTarNovo.Text := edtRedTarAtual.Text;
  chkUsaTarAtual.Checked := Usa;
  chkUsaTarNovo.Checked := Usa;
end;

function TframeComparativo.fEntradaCusto(const Ler: TLeitorCampo; const ConverterMoeda: Boolean): TCustoEntrada;
var
  Indice: Integer;
begin
  FillChar(Result, SizeOf(Result), 0);

  Result.PrecoCompra := Ler('ITE_PRECOM');
  for Indice := Low(Result.Descontos) to High(Result.Descontos) do
    Result.Descontos[Indice] := Ler('ITE_DESF0' + IntToStr(Indice));
  Result.IcmsEntrada := Ler('ITE_ICMENT');
  Result.IpiEntrada := Ler('ITE_IPIENT');
  Result.FreteEntrada := Ler('ITE_FREENT');
  Result.ValorFrete := Ler('ITE_VALFRE');
  Result.AcrescimoFinanceiro := Ler('ITE_ACRFIN');
  Result.Substituicao := Ler('ITE_SUBSTI');
  Result.DescontoAdicional := Ler('ITE_DESADB');
  Result.SubFederal := Ler('ITE_SUBFED');
  Result.SuframaTcif := Ler('ITE_TCIFCU');
  Result.SuframaTs := Ler('ITE_TSCUST');
  Result.SuframaDescontoPisCofins := Ler('ITE_DEPICO');
  Result.SuframaDescontoIcms := Ler('ITE_DEICMS');
  Result.SuframaFatorRegional := Ler('ITE_FATREG');
  Result.ConverterMoeda := ConverterMoeda;
end;

// Campos calculados do lado Atual: o valor vem do produto no host, nunca da simulacao.
procedure TframeComparativo.pAtualizarAtual;
var
  Produto: IDadosProduto;
begin
  Produto := FHost.Produto;

  if Produto.CodigoItem = '' then
  begin
    pLimparCalculadosAtual;
    Exit;
  end;

  pExibirCalculadosAtual(
    function(const Campo: string): Double
    begin
      Result := Produto.ValorNumerico(Campo);
    end,
    Produto.ValorTexto('ITE_PREDOL') = 'S');
end;

procedure TframeComparativo.pLimparCalculadosAtual;
begin
  edtComLiqAtual.Clear;
  edtCusReaAtual.Clear;
  edtCusVen1Atual.Clear;
  edtDolar1Atual.Clear;
  edtValDesOpeAtual.Clear;
end;

// Mesmo calculo do host para o produto (lado Atual) ou para a linha da ITEREO (Antes da Conversao).
procedure TframeComparativo.pExibirCalculadosAtual(const Ler: TLeitorCampo; const ConverterMoeda: Boolean);
var
  Custo: TCustoEntrada;
  PrecoCusto: Double;
  IcmsSaida: Double;
  Reducao: Double;
  CustoReal: TCustoRealEntrada;
  Digitos: Integer;
  Cotacao: Double;
  PrecoVenda1: Double;
  ExibeDolar: Boolean;
begin
  Digitos := FConfiguracao.DecimaisUnitarios;

  edtComLiqAtual.Text := FormatFloat(fMascara(Digitos),
    FHost.CalculoCusto.PrecoCompraLiquido(fEntradaCusto(Ler, ConverterMoeda)));

  CustoReal.PrecoCusto := Ler('ITE_PRECUS');
  CustoReal.OutrosValores := Ler('ITE_OUTVAL');
  CustoReal.IcmsSaida := Ler('ITE_ICMSAI');
  CustoReal.ImpostoFederal := Ler('ITE_IMPFED');
  CustoReal.DespesaOperacional := Ler('ITE_DESOPE');
  if FConfiguracao.MargemMarkup = 4 then
    edtCusReaAtual.Text := FormatFloat(fMascara(4), FHost.CalculoCusto.CustoReal(CustoReal))
  else
    edtCusReaAtual.Text := FormatFloat(fMascara(Digitos), FHost.CalculoCusto.CustoReal(CustoReal));

  PrecoVenda1 := Ler('ITE_PREVE1');
  // Tabela 1 com Reducao TARE: custo com o ICMS de entrada reduzido e ICMS de saida reduzido, como o custo de venda da
  // aba 1 (fCalculaCustoVendaTabela) e o lado Novo (TCalculoFormacao.AplicarTare). Teste de 2026-10-15.
  PrecoCusto := Ler('ITE_PRECUS');
  IcmsSaida := Ler('ITE_ICMSAI');
  Reducao := FHost.Produto.ValorNumerico(CAMPO_REDUCAO_TARE + '1');
  if Reducao <> 0 then
  begin
    Custo := fEntradaCusto(Ler, ConverterMoeda);
    Custo.IcmsEntrada := Custo.IcmsEntrada * (100 - Reducao) / 100;
    PrecoCusto := FHost.CalculoCusto.PrecoCusto(Custo);
    IcmsSaida := IcmsSaida * (100 - Reducao) / 100;
  end;
  edtCusVen1Atual.Text := FormatFloat(fMascara(Digitos), fCustoVenda(FConfiguracao,
    PrecoCusto, Ler('ITE_OUTVAL'), PrecoVenda1,
    IcmsSaida, Ler('ITE_IMPFED'),
    Ler('ITE_DESOPE'), Ler('ITE_COMTB1')));
  pAtualizarTare;

  // Valor (R$) da despesa operacional sobre o preco de venda da tabela 1. No modo conversao fica oculto.
  if not Assigned(FConsulta) then
    edtValDesOpeAtual.Text := FormatFloat(fMascara(Digitos), PrecoVenda1 * Ler('ITE_DESOPE') / 100);

  // pAjustaDolarAtual: o preco em dolar so aparece com a opcao ligada e cotacao cadastrada.
  Cotacao := 0;
  if chkPreDolAtual.Visible then
    Cotacao := FHost.CotacaoDolarVenda;
  ExibeDolar := chkPreDolAtual.Visible and (Cotacao > 0);
  lblDolar1Atual.Visible := ExibeDolar;
  edtDolar1Atual.Visible := ExibeDolar;
  if ExibeDolar then
    edtDolar1Atual.Text := FormatFloat(fMascara(Digitos), PrecoVenda1 / Cotacao)
  else
    edtDolar1Atual.Clear;
end;

// Antes da Conversao: os calculados da linha da ITEREO, com o calculo do host (como a aba 1 mostrava).
procedure TframeComparativo.pAtualizarAntes;
var
  Antes: TDataSet;
begin
  Antes := FConsulta.Antes;
  if Antes.IsEmpty then
  begin
    pLimparCalculadosAtual;
    Exit;
  end;

  pExibirCalculadosAtual(
    function(const Campo: string): Double
    begin
      Result := Antes.FieldByName(Campo).AsFloat;
    end,
    Antes.FieldByName('ITE_PREDOL').AsString = 'S');
end;

// Apos Conversao: o que a ITEREF nao guarda (preco de compra liquido, custo real e preco com impostos) sai do motor do
// plugin com os valores e o CBS/IBS/IS da linha. grCarga nao reescreve custo, preco de venda nem margem.
procedure TframeComparativo.pAtualizarApos;
var
  Apos: TDataSet;
  Formacao: TFormacaoCusto;
  Digitos: Integer;
begin
  Apos := FConsulta.Apos;
  if Apos.IsEmpty then
  begin
    edtComLiqNovo.Clear;
    edtCusReaNovo.Clear;
    Exit;
  end;

  FillChar(Formacao, SizeOf(Formacao), 0);
  Formacao.Lado := lsNovo;
  Formacao.Estado := FHost.Produto.Estado;
  // O preco de compra da ITEREF ja tem o desconto PIS/COFINS: nao entra de novo.
  Formacao := fLerFormacao(Apos, Formacao, False);
  FCalculo.Recalcular(Formacao, grCarga);

  Apos.Edit;
  Apos.FieldByName('ITE_PRECL1').AsFloat := Formacao.Tabelas[1].PrecoCliente;
  Apos.Post;

  Digitos := FConfiguracao.DecimaisUnitarios;
  pAtualizarTare;
  edtComLiqNovo.Text := FormatFloat(fMascara(Digitos), Formacao.PrecoCompraLiquido);
  if FConfiguracao.MargemMarkup = 4 then
    edtCusReaNovo.Text := FormatFloat(fMascara(4), Formacao.CustoReal)
  else
    edtCusReaNovo.Text := FormatFloat(fMascara(Digitos), Formacao.CustoReal);
end;

procedure TframeComparativo.AtualizarAtual;
begin
  // Modo conversao: a aba mostra o registro da conversao, nao o produto em edicao (RN09).
  if Assigned(FConsulta) then
    Exit;

  pAtualizarAtual;
  AplicarEstado;
end;

procedure TframeComparativo.AplicarEstado;
var
  Editando: Boolean;
begin
  // Modo conversao: somente leitura em consulta, inclusao e alteracao. Empresa que recebe os precos da matriz
  // (PrecosDaMatriz) tambem so consulta, como a aba 1 dela (teste de 2026-10-15).
  Editando := not Assigned(FConsulta) and not FConfiguracao.PrecosDaMatriz and
    (FHost.Produto.Estado in [ecInclusao, ecAlteracao]);
  pAplicarEstadoEdicao(Self, Editando);
  if Editando and fCustoBloqueado(FHost, FSemAcessoCusto) then
  begin
    pBloquearCusto(fControlesNovo);
    pBloquearCustoAtual;
  end;
end;

// Lado Atual sem EDTCUS: os campos de compra, custo e custo real do produto (o lado Atual edita o produto do host).
procedure TframeComparativo.pBloquearCustoAtual;

  procedure pBloquear(const Painel: TWinControl);
  var
    Indice: Integer;
  begin
    for Indice := 0 to Painel.ControlCount - 1 do
      if Painel.Controls[Indice] is TDBEditFocus then
        TDBEditFocus(Painel.Controls[Indice]).Enabled := False
      else if Painel.Controls[Indice] is TWinControl then
        pBloquear(TWinControl(Painel.Controls[Indice]));
  end;

begin
  pBloquear(pnlPrecoCompraAtual);
  pBloquear(pnlCamposSuframaAtual);
  pBloquear(pnlOutValAtual);
end;

procedure TframeComparativo.Entrar;
begin
  if Assigned(FConsulta) then
  begin
    // So le se o item mudou desde a ultima leitura (RF08). Sem linha os dois grupos ficam em branco (RF07).
    FConsulta.Carregar(FHost.Produto.CodigoItem);
    AplicarEstado;
    pAtualizarAntes;
    pAtualizarApos;
  end
  else
    // Aliquotas e revalidacao ao abrir a aba nao sao edicao do usuario: nao marcam pendencia.
    FSimulacao.ExecutarSemMarcar(
      procedure
      begin
        FSimulacao.CarregarAliquotas;
        AplicarEstado;
        pAtualizarAtual;
        pValidarNovo(dbePreComNovo);
      end);
  pAcompanharCoresAba1(FHost, Self, ['Atual', 'Novo']);
  pAjustarBarra(scrComparativoAtual);
  pAjustarBarra(scrComparativoNovo);
end;

// A barra de rolagem so existe se o conteudo nao cabe. AutoScroll do VCL conta o espaco em branco
// abaixo do ultimo campo do ultimo painel, entao mostrava a barra sem necessidade: aqui o intervalo
// e ate o fundo do ultimo controle visivel.
procedure TframeComparativo.pAjustarBarra(const Caixa: TScrollBox);
var
  Indice: Integer;
  Filho: Integer;
  Topo: Integer;
  Fundo: Integer;
  Maior: Integer;
  Ultimo: TControl;
  Interno: Integer;
begin
  Maior := 0;
  Ultimo := nil;
  for Indice := 0 to Caixa.ControlCount - 1 do
    if Caixa.Controls[Indice].Visible then
    begin
      Fundo := Caixa.Controls[Indice].Top + Caixa.VertScrollBar.Position + Caixa.Controls[Indice].Height;
      if Fundo > Maior then
      begin
        Maior := Fundo;
        Ultimo := Caixa.Controls[Indice];
      end;
    end;

  if Ultimo is TWinControl then
  begin
    Interno := 0;
    Topo := Ultimo.Top + Caixa.VertScrollBar.Position;
    for Filho := 0 to TWinControl(Ultimo).ControlCount - 1 do
      if TWinControl(Ultimo).Controls[Filho].Visible then
        Interno := Max(Interno, TWinControl(Ultimo).Controls[Filho].Top + TWinControl(Ultimo).Controls[Filho].Height);
    if Interno > 0 then
      Maior := Topo + Interno + 2;
  end;

  Caixa.VertScrollBar.Range := Maior;
end;

procedure TframeComparativo.pCaixaRedimensionada(Sender: TObject);
begin
  pAjustarBarra(Sender as TScrollBox);
end;

procedure TframeComparativo.pValidarNovo(Sender: TObject);
begin
  FValidador.Validar(Sender as TDBEditFocus);
end;

// O host valida e pode ter corrigido o valor; so depois o plugin reexibe os calculados. Com CFG_REFCIS = 'N' o
// lado Novo acompanha o que mudou no Atual (REFTRI-01).
procedure TframeComparativo.pValidarAtual(Sender: TObject);
var
  Edt: TDBEditFocus;
begin
  Edt := Sender as TDBEditFocus;

  if not FHost.Produto.ValidarCampo(Edt.DataField) then
    FHost.FocarControle(Edt.Handle);

  FSimulacao.SincronizarProduto;
  pAtualizarAtual;
end;

procedure TframeComparativo.pMargemNovoEntrar(Sender: TObject);
begin
  FSimulacao.DefinirFormatoMargem(1, 8);
end;

procedure TframeComparativo.pPrecoClienteTecla(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FValidador.TeclaNoPrecoCliente(Key);
end;

procedure TframeComparativo.pPrecoDolarNovoClick(Sender: TObject);
begin
  if (FHost.TextoParaNumero(dbePreComNovo.Text) <> 0) and FSimulacao.Dados.Active and
     (FSimulacao.Dados.State <> dsBrowse) then
    pValidarNovo(dbePreComNovo);
end;

end.