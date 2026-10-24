unit Reforma.View.Validacao;

// pValidarPrecosNovo e pValidarPrecosFutura da calculadora sao a mesma regra sobre conjuntos de
// controles diferentes. Aqui ela existe uma vez; cada aba entrega os seus controles.
// Diferenca mantida: so o lado Novo retem o foco no preco cliente.

interface

uses
  System.Classes, Vcl.ExtCtrls, DBEditFocus,
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Host,
  Reforma.Simulacao.Modelo;

// Habilita ou desabilita os campos de entrada do frame conforme o estado do cadastro no host
// (dsEditModes): consulta desabilita, inclusao e alteracao habilitam.
procedure pAplicarEstadoEdicao(const Dono: TComponent; const Editando: Boolean);
// REFTRI-01 (CFG_REFCIS = 'N'): os campos da simulacao que a REFPRE nao guarda deixam de ser digitaveis, porque
// seguem o produto (TSimulacaoReforma.SincronizarProduto). Saem do TabStop para pAplicarEstadoEdicao nao os
// habilitar de novo. Com 'S' nada muda.
procedure pTravarCamposDoProduto(const Dono: TComponent; const Simulacao: TSimulacaoReforma);

type
  TControlesTabela = array[1..QUANTIDADE_TABELAS_PRECO] of TDBEditFocus;

  TControlesPrecos = record
    PrecoCompra: TDBEditFocus;
    Descontos: array[1..6] of TDBEditFocus;
    IcmsEntrada: TDBEditFocus;
    IpiEntrada: TDBEditFocus;
    FreteEntrada: TDBEditFocus;
    ValorFrete: TDBEditFocus;
    AcrescimoFinanceiro: TDBEditFocus;
    Substituicao: TDBEditFocus;
    DescontoAdicional: TDBEditFocus;
    SuframaTcif: TDBEditFocus;
    SuframaTs: TDBEditFocus;
    SuframaPisCofins: TDBEditFocus;
    SuframaIcms: TDBEditFocus;
    SuframaFatorRegional: TDBEditFocus;
    OutrosValores: TDBEditFocus;
    IcmsSaida: TDBEditFocus;
    DespesaOperacional: TDBEditFocus;
    // Desconto PIS/COFINS 2027 (REFTRI-01): so a aba 2 tem o campo; nil na aba 3.
    DescontoPisCofins: TDBEditFocus;
    // Posicoes nao usadas ficam nil (a aba 2 so tem a tabela 1).
    MargemBruta: TControlesTabela;
    Comissao: TControlesTabela;
    PrecoVenda: TControlesTabela;
    PrecoCliente: TControlesTabela;
    PainelSuframa: TPanel;
    RetemFocoNoPrecoCliente: Boolean;
    // Aba 3 grid: margem e comissao vivem num grid, sem TDBEditFocus. A soma de 100% le os valores
    // da simulacao para as tabelas cujo controle e nil.
    MargensDaSimulacao: Boolean;
  end;

  TValidadorPrecos = class
  strict private
    type
      TTipoCampo = (tcOutro, tcMargem, tcComissao, tcPrecoVenda, tcPrecoCliente);
    var
      FHost: IReformaHost;
      FSimulacao: TSimulacaoReforma;
      FControles: TControlesPrecos;
      FConfiguracao: TConfiguracaoReforma;
      FSairDoPreco: Boolean;
    function fNumero(const Texto: string): Double;
    function fVazio(const Texto: string): Boolean;
    function fLocalizar(const Lista: TControlesTabela; const Edt: TDBEditFocus): Integer;
    function fClassificar(const Edt: TDBEditFocus; out Tabela: Integer): TTipoCampo;
    function fEhDesconto(const Edt: TDBEditFocus): Boolean;
    function fEscala(const Edt: TDBEditFocus; const Minimo, Maximo: Double;
      const Titulo, Mensagem: string; const ZerarPeloCampo: Boolean = False): Boolean;
    function fMensagemMargem: string;
    function fMargemValida(const Tabela: Integer): Boolean;
    function fTodasMargensValidas: Boolean;
    function fExigeValidarMargem: Boolean;
    function fValidarPrecoCompra(const Edt: TDBEditFocus): Boolean;
    function fValidarDescontoPisCofins(const Edt: TDBEditFocus): Boolean;
    function fValidarIcmsSaida(const Edt: TDBEditFocus): Boolean;
    function fValidarDespesa(const Edt: TDBEditFocus; const Mensagem: string;
      const ZerarPeloCampo: Boolean = False): Boolean;
    function fValidarMargemBruta(const Edt: TDBEditFocus; const Tabela: Integer): Boolean;
    function fValidarComissao(const Edt: TDBEditFocus; const Tabela: Integer): Boolean;
    function fValidarPrecoVenda(const Edt: TDBEditFocus; const Tabela: Integer): Boolean;
    function fValidarPrecoCliente(const Edt: TDBEditFocus; const Tabela: Integer): Boolean;
    function fValidarCampoSimples(const Edt: TDBEditFocus): Boolean;
    procedure pLimitarMaximo(const Edt: TDBEditFocus);
    function fSuframaVisivel: Boolean;
  public
    constructor Create(const Host: IReformaHost; const Simulacao: TSimulacaoReforma;
      const Controles: TControlesPrecos);
    // True quando o valor foi aceito. FocarSeInvalido = False: quem chama devolve o foco (grid).
    function Validar(const Edt: TDBEditFocus; const FocarSeInvalido: Boolean = True): Boolean;
    // FormKeyDown do cadastro: Enter no preco cliente permite ficar no campo uma vez.
    procedure TeclaNoPrecoCliente(const Tecla: Word);
  end;

// EDTCUS (teste de 2026-10-15): sem o direito a aba 1 trava compra, custo e custo real na alteracao
// (TfraPrecoProduto.pBloqueiaCusto). Desabilita os mesmos campos; roda depois de pAplicarEstadoEdicao.
procedure pBloquearCusto(const Controles: TControlesPrecos);
// A aba segue a aba 1: True quando o operador nao tem EDTCUS e o produto esta em alteracao.
function fCustoBloqueado(const Host: IReformaHost; const SemAcessoCusto: Boolean): Boolean;
// CFG_REDTAR so existe na familia 150.x. No 72 e no 74.111 a configuracao nao existe (e nao deve existir): sem ela
// nao ha TARE.
function fReducaoTareAtiva(const Host: IReformaHost): Boolean;
// Sem o direito PROTABPR, com CFG_VISABA, o operador ve a composicao do custo sem as tabelas de preco (teste de
// 2026-10-16), como a aba 1. CFG_VISABA nao existe no 72, 74.111 e 150.45: sem ela nada some.
function fTabelasOcultas(const Host: IReformaHost): Boolean;

implementation

uses
  System.SysUtils, System.Variants, Data.DB, Winapi.Windows, Vcl.Controls, EditFocus,
  Reforma.Calculo.Formacao;

const
  MAXIMO_VALOR = 9999999999.99;

// Mesma regra de pEnabled (untFuncoesSimples): so controles com TabStop seguem o estado; os campos
// calculados (sem TabStop) ficam como o DFM os deixou.
procedure pAplicarEstadoEdicao(const Dono: TComponent; const Editando: Boolean);
var
  Indice: Integer;
  Controle: TComponent;
begin
  for Indice := 0 to Dono.ComponentCount - 1 do
  begin
    Controle := Dono.Components[Indice];
    if ((Controle is TDBEditFocus) or (Controle is TEditFocus)) and (Controle.Tag <> 50) and
      TWinControl(Controle).TabStop then
      TWinControl(Controle).Enabled := Editando;
  end;
end;

procedure pBloquearCusto(const Controles: TControlesPrecos);

  procedure pBloquear(const Campo: TDBEditFocus);
  begin
    if Assigned(Campo) then
      Campo.Enabled := False;
  end;

var
  Indice: Integer;
begin
  pBloquear(Controles.PrecoCompra);
  for Indice := Low(Controles.Descontos) to High(Controles.Descontos) do
    pBloquear(Controles.Descontos[Indice]);
  pBloquear(Controles.IcmsEntrada);
  pBloquear(Controles.IpiEntrada);
  pBloquear(Controles.FreteEntrada);
  pBloquear(Controles.ValorFrete);
  pBloquear(Controles.AcrescimoFinanceiro);
  pBloquear(Controles.Substituicao);
  pBloquear(Controles.DescontoAdicional);
  pBloquear(Controles.SuframaTcif);
  pBloquear(Controles.SuframaTs);
  pBloquear(Controles.SuframaPisCofins);
  pBloquear(Controles.SuframaIcms);
  pBloquear(Controles.SuframaFatorRegional);
  pBloquear(Controles.OutrosValores);
  pBloquear(Controles.IcmsSaida);
  pBloquear(Controles.DespesaOperacional);
  pBloquear(Controles.DescontoPisCofins);
end;

function fCustoBloqueado(const Host: IReformaHost; const SemAcessoCusto: Boolean): Boolean;
begin
  Result := SemAcessoCusto and (Host.Produto.Estado = ecAlteracao);
end;

// Configuracao que pode nao existir na versao: lida direto da CFGSIS da empresa logada. O fCfgSis do host levanta
// excecao ou, conforme a versao, mostra a caixa "a configuracao nao existe" (teste de 2026-10-16, CFG_REDTAR no 72).
// Configuracao inexistente: False. SeFalhar: o valor quando a propria consulta falha (conexao, SQL), que nao chega
// a quem chama porque a excecao do host e de outro modulo e nao ha canal de log no contrato.
function fConfiguracaoLigada(const Host: IReformaHost; const Chave: string; const SeFalhar: Boolean): Boolean;
var
  Consulta: IReformaConsulta;
begin
  Result := False;
  try
    Consulta := Host.AbrirConsulta('SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODEMP = :CODEMP AND SIS_CODCFG = :CODCFG');
    Consulta.DefinirParametro('CODEMP', Host.CodigoEmpresa);
    Consulta.DefinirParametro('CODCFG', 'CFG_' + Chave);
    Consulta.Abrir;
    if not Consulta.Vazia then
      Result := SameText(Trim(VarToStr(Consulta.ValorCampo('SIS_VALCFG'))), 'S');
  except
    // Excecao do host: classe de outro modulo, nao da para tratar por tipo.
    Result := SeFalhar;
  end;
end;

function fReducaoTareAtiva(const Host: IReformaHost): Boolean;
begin
  Result := fConfiguracaoLigada(Host, 'REDTAR', False);
end;

function fTabelasOcultas(const Host: IReformaHost): Boolean;
begin
  // O 72 e o 74.111 respondem True a qualquer direito: nem chegam a ler a CFG_VISABA. Falha na leitura oculta as
  // tabelas: quem nao tem o direito nao as ve por causa de um erro.
  Result := not Host.Acesso('PROTABPR') and fConfiguracaoLigada(Host, 'VISABA', True);
end;

procedure pTravarCamposDoProduto(const Dono: TComponent; const Simulacao: TSimulacaoReforma);
var
  Indice: Integer;
  Campo: TDBEditFocus;
begin
  if not Simulacao.UsaDescontoPisCofins then
    Exit;

  for Indice := 0 to Dono.ComponentCount - 1 do
    if Dono.Components[Indice] is TDBEditFocus then
    begin
      Campo := TDBEditFocus(Dono.Components[Indice]);
      // So os digitaveis da simulacao: o lado Atual e os calculados (sem TabStop ou somente leitura) ficam.
      if Assigned(Campo.DataSource) and (Campo.DataSource.DataSet = Simulacao.Dados) and Campo.TabStop and
         not Campo.ReadOnly and not Simulacao.CampoEditavel(Campo.DataField) then
      begin
        Campo.TabStop := False;
        Campo.ReadOnly := True;
        Campo.Enabled := False;
      end;
    end;
end;

constructor TValidadorPrecos.Create(const Host: IReformaHost; const Simulacao: TSimulacaoReforma;
  const Controles: TControlesPrecos);
begin
  inherited Create;
  FHost := Host;
  FSimulacao := Simulacao;
  FControles := Controles;
  FConfiguracao := Host.Configuracao;
  FSairDoPreco := True;
end;

function TValidadorPrecos.fNumero(const Texto: string): Double;
begin
  Result := FHost.TextoParaNumero(Texto);
end;

function TValidadorPrecos.fVazio(const Texto: string): Boolean;
begin
  Result := Trim(Texto) = '';
end;

function TValidadorPrecos.fLocalizar(const Lista: TControlesTabela; const Edt: TDBEditFocus): Integer;
var
  Indice: Integer;
begin
  Result := 0;
  for Indice := Low(Lista) to High(Lista) do
    if Assigned(Lista[Indice]) and (Lista[Indice] = Edt) then
      Exit(Indice);
end;

function TValidadorPrecos.fClassificar(const Edt: TDBEditFocus; out Tabela: Integer): TTipoCampo;
begin
  Result := tcOutro;
  Tabela := 1;

  // Como na calculadora, so campos visiveis entram nas regras de tabela.
  if not Edt.Visible then
    Exit;

  Tabela := fLocalizar(FControles.MargemBruta, Edt);
  if Tabela > 0 then
    Exit(tcMargem);
  Tabela := fLocalizar(FControles.Comissao, Edt);
  if Tabela > 0 then
    Exit(tcComissao);
  Tabela := fLocalizar(FControles.PrecoVenda, Edt);
  if Tabela > 0 then
    Exit(tcPrecoVenda);
  Tabela := fLocalizar(FControles.PrecoCliente, Edt);
  if Tabela > 0 then
    Exit(tcPrecoCliente);

  Tabela := 1;
end;

function TValidadorPrecos.fEhDesconto(const Edt: TDBEditFocus): Boolean;
var
  Indice: Integer;
begin
  Result := False;
  for Indice := Low(FControles.Descontos) to High(FControles.Descontos) do
    if FControles.Descontos[Indice] = Edt then
      Exit(True);
end;

function TValidadorPrecos.fSuframaVisivel: Boolean;
begin
  Result := Assigned(FControles.PainelSuframa) and FControles.PainelSuframa.Visible;
end;

function TValidadorPrecos.fEscala(const Edt: TDBEditFocus; const Minimo, Maximo: Double;
  const Titulo, Mensagem: string; const ZerarPeloCampo: Boolean): Boolean;
var
  Valor: Double;
begin
  Result := True;

  if fVazio(Edt.Text) then
  begin
    // A calculadora zera por caminhos diferentes conforme o campo; o efeito na tela e o mesmo.
    if ZerarPeloCampo then
      Edt.Field.AsFloat := 0.0
    else
      Edt.Text := '0';
    Exit;
  end;

  Valor := fNumero(Edt.Text);
  if (Valor < Minimo) or (Valor > Maximo) then
  begin
    FHost.Mensagem(Titulo, Mensagem);
    Result := False;
  end;
end;

function TValidadorPrecos.fMensagemMargem: string;
begin
  Result := 'A soma do ( ICMS Saída + Despesas Operacionais + Margem Bruta ';
  if FHost.ConfiguracaoTexto('PCMPRO') = '2' then
    Result := Result + '+ Comissão ';
  Result := Result + '  ) não pode ser superior a 100%.';
end;

// fValidaMargemNovo / fValidaMargemFutura.
function TValidadorPrecos.fMargemValida(const Tabela: Integer): Boolean;
var
  Margem: Double;
  Comissao: Double;
begin
  Result := True;
  if not FConfiguracao.TabelaAtiva[Tabela] then
    Exit;

  if Assigned(FControles.MargemBruta[Tabela]) then
  begin
    Margem := fNumero(FControles.MargemBruta[Tabela].Text);
    Comissao := fNumero(FControles.Comissao[Tabela].Text);
  end
  else if FControles.MargensDaSimulacao then
  begin
    Margem := FSimulacao.Dados.FieldByName('ITE_MARBR' + IntToStr(Tabela)).AsFloat;
    Comissao := FSimulacao.Dados.FieldByName('ITE_COMTB' + IntToStr(Tabela)).AsFloat;
  end
  else
    Exit;

  if FConfiguracao.MargemMarkup = 2 then
    Margem := FHost.CalculoMargem.MarkupParaMargem(Margem);

  Result := not ((Margem + Comissao + fNumero(FControles.IcmsSaida.Text) +
                  fNumero(FControles.DespesaOperacional.Text)) > 100);
end;

function TValidadorPrecos.fTodasMargensValidas: Boolean;
var
  Tabela: Integer;
begin
  Result := True;
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    Result := Result and fMargemValida(Tabela);
end;

// Margem (1 e 5) e markup (2) sao validados contra a soma de 100%; 3 e 4 nao.
function TValidadorPrecos.fExigeValidarMargem: Boolean;
begin
  Result := FConfiguracao.MargemMarkup in [1, 2, 5];
end;

function TValidadorPrecos.fValidarPrecoCompra(const Edt: TDBEditFocus): Boolean;
begin
  Result := True;
  if fVazio(Edt.Text) then
  begin
    FHost.Mensagem('ATENÇÃO!', 'O Preço de Compra deve ser preenchido!');
    Result := False;
  end
  else if fNumero(Edt.Text) <= 0.0 then
  begin
    FHost.Mensagem('ATENÇÃO!', 'O Preço de Compra deve ser maior que Zero!');
    Result := False;
  end
  // Aba 3 com o desconto PIS/COFINS ligado: o campo mostra o preco com desconto, e editar refaz o preco de
  // compra de tras para frente (RN04 do REFTRI-01).
  else if SameText(Edt.DataField, 'ITE_PRELIQ') then
    FSimulacao.Recalcular(grPrecoLiquido)
  else
    FSimulacao.Recalcular(grCusto);
end;

// RN03 do REFTRI-01: vazio vale 0; fora de 0 <= x < 100 o valor volta ao ultimo aceito (o da formacao), porque
// o OnExit ja passou o texto para o campo e o recalculo seguinte o leria.
function TValidadorPrecos.fValidarDescontoPisCofins(const Edt: TDBEditFocus): Boolean;
var
  Valor: Double;
begin
  Result := True;

  if fVazio(Edt.Text) then
    Valor := 0
  else
    Valor := fNumero(Edt.Text);

  if (Valor < 0) or (Valor >= 100) then
  begin
    FHost.Mensagem('ATENÇÃO!', 'O Desconto de PIS/COFINS deve ser maior ou igual a Zero e menor que 100!');
    Valor := FSimulacao.Formacao.DescontoPisCofins;
    Result := False;
  end
  else if not fVazio(Edt.Text) then
    Exit;

  if not (Edt.Field.DataSet.State in dsEditModes) then
    Edt.Field.DataSet.Edit;
  Edt.Field.AsFloat := Valor;
end;

// ICMS de saida e, junto com as despesas, o que fecha a soma de 100% da margem.
function TValidadorPrecos.fValidarIcmsSaida(const Edt: TDBEditFocus): Boolean;
begin
  Result := fEscala(Edt, 0, 100, '', 'O ICMS de Saida deve estar entre 0 e 100');

  if fExigeValidarMargem and Result and (fNumero(Edt.Text) > 0) and not fTodasMargensValidas then
  begin
    FHost.Mensagem('', fMensagemMargem);
    Result := False;
  end;
end;

function TValidadorPrecos.fValidarDespesa(const Edt: TDBEditFocus; const Mensagem: string;
  const ZerarPeloCampo: Boolean): Boolean;
begin
  // Como no cadastro, so a despesa operacional zera pelo campo; imposto federal zera pelo texto.
  Result := fEscala(Edt, 0, 100, 'ATENÇÃO!', Mensagem, ZerarPeloCampo);

  if fExigeValidarMargem and Result and (fNumero(Edt.Text) > 0) and not fTodasMargensValidas then
  begin
    FHost.Mensagem('', fMensagemMargem);
    Result := False;
  end;
end;

// O teto vai para o campo: a validacao roda depois do UpdateRecord do OnExit e o Recalcular le o campo,
// entao trocar so o Text nao limitava nada.
procedure TValidadorPrecos.pLimitarMaximo(const Edt: TDBEditFocus);
begin
  if fNumero(Edt.Text) <= MAXIMO_VALOR then
    Exit;

  if Assigned(Edt.Field) then
  begin
    if not (Edt.Field.DataSet.State in dsEditModes) then
      Edt.Field.DataSet.Edit;
    Edt.Field.AsFloat := MAXIMO_VALOR;
  end
  else
    Edt.Text := FloatToStr(MAXIMO_VALOR);
end;

function TValidadorPrecos.fValidarMargemBruta(const Edt: TDBEditFocus; const Tabela: Integer): Boolean;
begin
  Result := True;

  if not fVazio(Edt.Text) then
  begin
    pLimitarMaximo(Edt);

    if fExigeValidarMargem then
    begin
      if (fNumero(Edt.Text) >= 100) and (FConfiguracao.MargemMarkup <> 2) then
      begin
        FHost.Mensagem('ATENÇÃO!', 'Margem não permitida: maior ou igual a 100!');
        Result := False;
      end
      else if not fMargemValida(Tabela) then
      begin
        FHost.Mensagem('', fMensagemMargem);
        Result := False;
      end;
    end;
  end;

  if Result and FSimulacao.EmEdicao then
    FSimulacao.Recalcular(grMargem, Tabela);

  if Result then
    FSimulacao.DefinirFormatoMargem(Tabela, 2);
end;

function TValidadorPrecos.fValidarComissao(const Edt: TDBEditFocus; const Tabela: Integer): Boolean;
begin
  Result := True;

  if not fVazio(Edt.Text) then
  begin
    pLimitarMaximo(Edt);

    if fExigeValidarMargem then
    begin
      if (fNumero(Edt.Text) >= 100) and (FConfiguracao.MargemMarkup <> 2) then
      begin
        FHost.Mensagem('ATENÇÃO!', 'Comissão não permitida: maior ou igual a 100!');
        Result := False;
      end
      else if (fNumero(Edt.Text) < 0) and (FConfiguracao.MargemMarkup <> 2) then
      begin
        FHost.Mensagem('ATENÇÃO!', 'Comissão não permitida: menor que zero!');
        Result := False;
      end
      else if not fMargemValida(Tabela) then
      begin
        FHost.Mensagem('', fMensagemMargem);
        Result := False;
      end;
    end;
  end;

  if Result and FSimulacao.EmEdicao then
    FSimulacao.Recalcular(grComissao, Tabela);
end;

function TValidadorPrecos.fValidarPrecoVenda(const Edt: TDBEditFocus; const Tabela: Integer): Boolean;
begin
  Result := True;

  if fNumero(Edt.Text) <= 0 then
  begin
    FHost.Mensagem('', 'O Preço de Venda ' + IntToStr(Tabela) + ' deve ser maior que zero!');
    Result := False;
  end
  else if FSimulacao.EmEdicao then
    FSimulacao.Recalcular(grPrecoVenda, Tabela);
end;

function TValidadorPrecos.fValidarPrecoCliente(const Edt: TDBEditFocus; const Tabela: Integer): Boolean;
begin
  Result := True;

  if fNumero(Edt.Text) <= 0 then
  begin
    // A aba 2 nao numera a tabela na mensagem porque so tem uma.
    if FControles.RetemFocoNoPrecoCliente then
      FHost.Mensagem('', 'O Preço pago pelo cliente deve ser maior que zero!')
    else
      FHost.Mensagem('', 'O Preço pago pelo cliente ' + IntToStr(Tabela) + ' deve ser maior que zero!');
    Result := False;
  end
  else
    FSimulacao.Recalcular(grPrecoCliente, Tabela);

  // Enter no preco cliente da aba 2 mantem o foco uma vez (blnSairDoPreco no cadastro).
  if FControles.RetemFocoNoPrecoCliente and not FSairDoPreco then
  begin
    FSairDoPreco := True;
    FHost.FocarControle(Edt.Handle);
  end;
end;

procedure TValidadorPrecos.TeclaNoPrecoCliente(const Tecla: Word);
begin
  if Tecla = VK_RETURN then
    FSairDoPreco := False;
end;

// Campos cuja regra e so faixa de valores; o recalculo de custo fica em Validar.
function TValidadorPrecos.fValidarCampoSimples(const Edt: TDBEditFocus): Boolean;
begin
  Result := True;

  if Assigned(FControles.DescontoPisCofins) and (Edt = FControles.DescontoPisCofins) then
    Result := fValidarDescontoPisCofins(Edt)
  else if fEhDesconto(Edt) then
    Result := fEscala(Edt, 0, 100, 'ATENÇÃO!', 'O Desconto deve estar entre 0 e 100!')
  else if (Edt = FControles.IcmsEntrada) and Edt.Enabled then
    Result := fEscala(Edt, 0, 100, '', 'O ICMS de Entrada deve estar entre 0 e 100 ')
  else if (Edt = FControles.IcmsSaida) and Edt.Enabled then
    Result := fValidarIcmsSaida(Edt)
  else if Edt = FControles.OutrosValores then
  begin
    if fNumero(Edt.Text) < 0 then
    begin
      FHost.Mensagem('', 'O Valor do campo ' + LowerCase(FHost.ConfiguracaoTexto('DOVCPP')) +
        ' deve ser maior ou igual à zero!');
      Result := False;
    end;
  end
  else if (Edt = FControles.IpiEntrada) or (Edt = FControles.AcrescimoFinanceiro) or
          (Edt = FControles.DescontoAdicional) then
    Result := fEscala(Edt, 0, 100, 'ATENÇÃO!',
      'O Campo ' + Edt.Field.DisplayLabel + ' deve estar entre 0 e 100!')
  else if Edt = FControles.FreteEntrada then
    Result := fEscala(Edt, 0, 1000, 'ATENÇÃO!',
      'O Campo ' + Edt.Field.DisplayLabel + ' deve estar entre 0 e 1000!')
  else if Edt = FControles.Substituicao then
    Result := fEscala(Edt, 0, 100, 'ATENÇÃO!', 'O Campo Substituição Tributária deve estar entre 0 e 100!')
  else if Edt = FControles.ValorFrete then
  begin
    if fVazio(Edt.Text) then
      Edt.Text := '0'
    else if fNumero(Edt.Text) < 0.0 then
    begin
      FHost.Mensagem('ATENÇÃO!', 'O Campo "' + FHost.ConfiguracaoTexto('DESVFR') +
        '" deve ser maior ou igual a  zero!');
      Result := False;
    end;
  end
  else if Edt = FControles.DespesaOperacional then
    Result := fValidarDespesa(Edt, 'O Campo Despesas Operacionais deve estar entre 0 e 100!', True)
  else if (Edt = FControles.SuframaTcif) and fSuframaVisivel then
    Result := fEscala(Edt, 0, 100, 'ATENÇÃO!', 'O Campo TCIF deve estar entre 0 e 100!')
  else if (Edt = FControles.SuframaTs) and fSuframaVisivel then
    Result := fEscala(Edt, 0, 100, 'ATENÇÃO!', 'O Campo TS deve estar entre 0 e 100!')
  else if (Edt = FControles.SuframaPisCofins) and fSuframaVisivel then
    Result := fEscala(Edt, 0, 100, 'ATENÇÃO!', 'O Campo Desconto PIS/COFINS deve estar entre 0 e 100!')
  else if (Edt = FControles.SuframaIcms) and fSuframaVisivel then
    Result := fEscala(Edt, 0, 100, 'ATENÇÃO!', 'O Campo Desconto ICMS deve estar entre 0 e 100!')
  else if (Edt = FControles.SuframaFatorRegional) and fSuframaVisivel then
    Result := fEscala(Edt, 0, 100, 'ATENÇÃO!', 'O Campo Fator Regional deve estar entre 0 e 100!');
end;

function TValidadorPrecos.Validar(const Edt: TDBEditFocus; const FocarSeInvalido: Boolean): Boolean;
var
  Tabela: Integer;
  Tipo: TTipoCampo;
  Valido: Boolean;
begin
  Result := True;
  if FSimulacao.Dados.IsEmpty then
    Exit;

  if (FSimulacao.Dados.FieldByName('ITE_PRECOM').AsFloat = 0) and
     (FHost.Produto.Estado = ecConsulta) then
    Exit;

  Tipo := fClassificar(Edt, Tabela);

  case Tipo of
    tcMargem: Valido := fValidarMargemBruta(Edt, Tabela);
    tcComissao: Valido := fValidarComissao(Edt, Tabela);
    tcPrecoVenda: Valido := fValidarPrecoVenda(Edt, Tabela);
    tcPrecoCliente: Valido := fValidarPrecoCliente(Edt, Tabela);
  else
    if Edt = FControles.PrecoCompra then
      Valido := fValidarPrecoCompra(Edt)
    else
      Valido := fValidarCampoSimples(Edt);
  end;

  Result := Valido;
  if not Valido then
  begin
    if FocarSeInvalido then
      FHost.FocarControle(Edt.Handle);
  end
  else if Tipo = tcOutro then
    FSimulacao.Recalcular(grCusto);

  // A calculadora dispara o custo de venda no fim de toda validacao.
  FSimulacao.Recalcular(grExibicao);
end;

end.