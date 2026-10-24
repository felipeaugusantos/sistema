unit Faturamento.Impostos.Regras.AliquotasDeRetencao;

interface

uses Faturamento.Impostos.Interfaces.AliquotasDeRetencao,
    Faturamento.Impostos.Tipos.AliquotasDeRetencao,
    Faturamento.Impostos.Interfaces.Model,
    Faturamento.Model.Cliente,
    Shared.Functions.Configuracoes,
    Shared.Functions.Core,
    System.StrUtils;

type
  TRegrasAliquotasDeRetencao = class (TInterfacedObject, IRegrasAliquotasRetencao)
  private
    FParametros     : IParametrosAliquotasDeRetencao;
    FModelCliente   : IResultadoFaturamentoImpostosModelClienteFornecedor;
    FParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;
    FCodigoDoCliente: String;

    FAliquotaIRF    : Double;
    FAliquotaPIS    : Double;
    FAliquotaCOFINS : Double;
    FAliquotaCSL    : Double;

    FAliquotaProdutoIRF    : Double;
    FAliquotaProdutoPIS    : Double;
    FAliquotaProdutoCOFINS : Double;
    FAliquotaProdutoCSL    : Double;

    FValorMinimoRetencaoIRPJ : Double;
    FValorMinimoRetencaoPisCofinsCSLL: Double;

    procedure CarregarAliquotasCliente;

    procedure CarregarValoresConfiguracoesProdutosAliquotasOrgaoPublico;

    procedure CarregarValoresConfiguracoesAliquotasRetencaoPessoaJuridicaNaoOrgaoPublico;

    procedure CarregarRetencaoPessoaJuridica(const AOrgaoPublico : Boolean );

    function ValidarRetencaoPessoaJuridica : Boolean;

    function ClientePessoaJuridica : Boolean;

    Function ValidarSeDeveCalcularAliquotaIRF : Boolean;
    Function ValidarSeDeveCalcularAliquotaPisCofins : Boolean;

    function ValidarSeDeveZerarValoresAliquotaIRF : Double;
    function ValidarSeDeveZerarValoresAliquotaPIS: Double;
    function ValidarSeDeveZerarValoresAliquotaCofins : Double;
    function ValidarSeDeveZerarValoresAliquotaCSL : Double;

    function ValidarSeDeveZerarOrgaoPublicoValoresAliquotaIRF : Double;
    function ValidarSeDeveZerarOrgaoPublicoValoresAliquotaPIS: Double;
    function ValidarSeDeveZerarOrgaoPublicoValoresAliquotaCofins : Double;
    function ValidarSeDeveZerarOrgaoPublicoValoresAliquotaCSL : Double;


    function ValidarSeDeveZerarValoresProdutoAliquotaIRF : Double;
    function ValidarSeDeveZerarValoresProdutoAliquotaPIS: Double;
    function ValidarSeDeveZerarValoresProdutoAliquotaCofins : Double;
    function ValidarSeDeveZerarValoresProdutoAliquotaCSL : Double;

    function ValidaSeCalculaRetencoesParaSimplesNacional: Boolean;

    function RetonarAliquotaIRF : Double;
    function RetonarAliquotaPIS: Double;
    function RetonarAliquotaCofins : Double;
    function RetonarAliquotaCSL : Double;

  public
    constructor Create(AParametros: IParametrosAliquotasDeRetencao); virtual;

    class function New(AParametros: IParametrosAliquotasDeRetencao): IRegrasAliquotasRetencao;


    function CarregarModelCliente : IRegrasAliquotasRetencao;

    function UtilizarModelCliente(
      Const AParametros : IResultadoFaturamentoImpostosModelClienteFornecedor;
      Const AParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor = Nil) : IRegrasAliquotasRetencao;

    function CarregarAliquotasRetencao(AParametros: IParametrosAliquotasDeRetencao = Nil) : IResultadoAliquotasDeRetencao;

  end;

  function CarregarAliquotasRetencao(AParametros: IParametrosAliquotasDeRetencao = Nil): IResultadoAliquotasDeRetencao; stdcall;

implementation

{ TRegraAliquotasDeRetencao}

function CarregarAliquotasRetencao(AParametros: IParametrosAliquotasDeRetencao = Nil): IResultadoAliquotasDeRetencao; stdcall;
begin
  Result :=
    TRegrasAliquotasDeRetencao.New(AParametros)
      .CarregarModelCliente
        .CarregarAliquotasRetencao;
end;


function TRegrasAliquotasDeRetencao.ValidarSeDeveCalcularAliquotaIRF: Boolean;
begin
  If not ValidaSeCalculaRetencoesParaSimplesNacional Then
  Begin
    Result := False;
    Exit;
  End;

  Result := FModelCliente.RetencaoDeIRPF = 'S';
end;

function TRegrasAliquotasDeRetencao.ValidarSeDeveCalcularAliquotaPisCofins: Boolean;
begin
  If not ValidaSeCalculaRetencoesParaSimplesNacional Then
  Begin
    Result := False;
    Exit;
  End;

  Result := FModelCliente.RetencaoDePisCofins = 'S';
end;

procedure TRegrasAliquotasDeRetencao.CarregarAliquotasCliente;
begin
  FAliquotaIRF    := FModelCliente.ValorAliquotaIRF;
  FAliquotaPIS    := FModelCliente.ValorAliquotaPIS;
  FAliquotaCOFINS := FModelCliente.ValorAliquotaCOF;
  FAliquotaCSL    := FModelCliente.ValorAliquotaCSL;
end;

function TRegrasAliquotasDeRetencao.CarregarAliquotasRetencao(AParametros: IParametrosAliquotasDeRetencao = Nil): IResultadoAliquotasDeRetencao;
begin
  If ValidarRetencaoPessoaJuridica Then
  Begin
    CarregarRetencaoPessoaJuridica(FModelCliente.OrgaoPublico);

    FValorMinimoRetencaoIRPJ          := objConfiguracoes.fGetValorConfiguracao(CFG_VALOR_MINIMO_RETENCAO_IRPJ, varDouble);
    FValorMinimoRetencaoPisCofinsCSLL := objConfiguracoes.fGetValorConfiguracao(CFG_VALOR_MINIMO_RETENCAO_PIS_COFINS_CSLL, varDouble);
  End;

  Result :=
    TResultadoAliquotasDeRetencao.New
      .AliquotaIRPJ(FAliquotaIRF)
      .AliquotaPIS(FAliquotaPIS)
      .AliquotaCOFINS(FAliquotaCOFINS)
      .AliquotaCSLL(FAliquotaCSL)
      .AliquotaProdutoIRPJ(FAliquotaProdutoIRF)
      .AliquotaProdutoPIS(FAliquotaProdutoPIS)
      .AliquotaProdutoCOFINS(FAliquotaProdutoCOFINS)
      .AliquotaProdutoCSLL(FAliquotaProdutoCSL)
      .ValorMinimoRetencaoPisCofinsCsll(FValorMinimoRetencaoPisCofinsCSLL)
      .ValorMinimoRetencaoIRPJ(FValorMinimoRetencaoIRPJ);

end;

function TRegrasAliquotasDeRetencao.ValidarSeDeveZerarValoresProdutoAliquotaIRF : Double;
begin
  If Not ValidarSeDeveCalcularAliquotaIRF Then
  begin
    Result := 0;
    Exit;
  end;

  If Self.FAliquotaIRF <= 0 Then 
    Result := objConfiguracoes.fGetValorConfiguracao(CFG_PRODUTO_ALIQUOTA_IRPJ, varDouble)
  Else  
    Result := Self.FAliquotaIRF;
end;

function TRegrasAliquotasDeRetencao.ValidarSeDeveZerarValoresProdutoAliquotaPIS: Double;
begin
  If Not ValidarSeDeveCalcularAliquotaPisCofins Then
  begin
    Result := 0;
    Exit;
  end;

  If Self.FAliquotaPIS <= 0 Then
    Result := objConfiguracoes.fGetValorConfiguracao(CFG_PRODUTO_ALIQUOTA_PIS, varDouble)
  Else  
    Result := Self.FAliquotaPIS;
end;

function TRegrasAliquotasDeRetencao.ValidarSeDeveZerarValoresProdutoAliquotaCofins : Double;
begin
  If Not ValidarSeDeveCalcularAliquotaPisCofins Then
  begin
    Result := 0;
    Exit;
  end;

  If Self.FAliquotaCOFINS <= 0 Then
    Result := objConfiguracoes.fGetValorConfiguracao(CFG_PRODUTO_ALIQUOTA_COFINS, varDouble)
  Else
    Result := Self.FAliquotaCOFINS
end;

function TRegrasAliquotasDeRetencao.ValidarSeDeveZerarValoresProdutoAliquotaCSL : Double;
begin
  If Not ValidarSeDeveCalcularAliquotaPisCofins Then
  begin
    Result := 0;
    Exit;
  end;

  If Self.FAliquotaCSL <= 0 Then
    Result := objConfiguracoes.fGetValorConfiguracao(CFG_PRODUTO_ALIQUOTA_CSLL, varDouble)
  Else  
    Result := Self.FAliquotaCSL;
end;


function TRegrasAliquotasDeRetencao.ValidarSeDeveZerarOrgaoPublicoValoresAliquotaCofins: Double;
begin
  If Not ValidarSeDeveCalcularAliquotaPisCofins Then
  begin
    Result := 0;
    Exit;
  end;

  Result := RetonarAliquotaCofins;
end;

function TRegrasAliquotasDeRetencao.ValidarSeDeveZerarOrgaoPublicoValoresAliquotaCSL: Double;
begin
  If Not ValidarSeDeveCalcularAliquotaPisCofins Then
  begin
    Result := 0;
    Exit;
  end;

  Result := RetonarAliquotaCSL;
end;

function TRegrasAliquotasDeRetencao.ValidarSeDeveZerarOrgaoPublicoValoresAliquotaIRF: Double;
begin
  If Not ValidarSeDeveCalcularAliquotaIRF Then
  begin
    Result := 0;
    Exit;
  end;

  Result := RetonarAliquotaIRF;
end;

function TRegrasAliquotasDeRetencao.ValidarSeDeveZerarOrgaoPublicoValoresAliquotaPIS: Double;
begin
  If Not ValidarSeDeveCalcularAliquotaPisCofins Then
  begin
    Result := 0;
    Exit;
  end;

  Result := RetonarAliquotaPIS;
end;

function TRegrasAliquotasDeRetencao.ValidarSeDeveZerarValoresAliquotaCofins: Double;
begin
  If Not ValidarSeDeveCalcularAliquotaPisCofins Then
  begin
    Result := 0;
    Exit;
  end;

  Result := objConfiguracoes.fGetValorConfiguracao(CFG_SERVICO_NAO_ORGAO_PUBLICO_ALIQUOTA_COFINS, varDouble);
end;

function TRegrasAliquotasDeRetencao.ValidarSeDeveZerarValoresAliquotaCSL: Double;
begin
  If Not ValidarSeDeveCalcularAliquotaPisCofins Then
  begin
    Result := 0;
    Exit;
  end;

  Result := objConfiguracoes.fGetValorConfiguracao(CFG_SERVICO_NAO_ORGAO_PUBLICO_ALIQUOTA_CSLL, varDouble);
end;

function TRegrasAliquotasDeRetencao.ValidarSeDeveZerarValoresAliquotaIRF: Double;
begin
  If Not ValidarSeDeveCalcularAliquotaIRF Then
  begin
    Result := 0;
    Exit;
  end;

  Result := objConfiguracoes.fGetValorConfiguracao(CFG_SERVICO_NAO_ORGAO_PUBLICO_ALIQUOTA_IRPJ, varDouble);
end;

function TRegrasAliquotasDeRetencao.ValidarSeDeveZerarValoresAliquotaPIS: Double;
begin
  If Not ValidarSeDeveCalcularAliquotaPisCofins Then
  begin
    Result := 0;
    Exit;
  end;

  Result := objConfiguracoes.fGetValorConfiguracao(CFG_SERVICO_NAO_ORGAO_PUBLICO_ALIQUOTA_PIS, varDouble);
end;

procedure TRegrasAliquotasDeRetencao.CarregarValoresConfiguracoesProdutosAliquotasOrgaoPublico;
begin
  FAliquotaProdutoIRF    := ValidarSeDeveZerarValoresProdutoAliquotaIRF;
  FAliquotaProdutoPIS    := ValidarSeDeveZerarValoresProdutoAliquotaPIS;
  FAliquotaProdutoCOFINS := ValidarSeDeveZerarValoresProdutoAliquotaCofins;
  FAliquotaProdutoCSL    := ValidarSeDeveZerarValoresProdutoAliquotaCSL;
end;

procedure TRegrasAliquotasDeRetencao.CarregarValoresConfiguracoesAliquotasRetencaoPessoaJuridicaNaoOrgaoPublico;
begin
  FAliquotaIRF    := ValidarSeDeveZerarValoresAliquotaIRF;
  FAliquotaPIS    := ValidarSeDeveZerarValoresAliquotaPIS;
  FAliquotaCOFINS := ValidarSeDeveZerarValoresAliquotaCofins;
  FAliquotaCSL    := ValidarSeDeveZerarValoresAliquotaCSL;
end;

function TRegrasAliquotasDeRetencao.CarregarModelCliente :IRegrasAliquotasRetencao;
begin
  Result := Self;

  FModelCliente:=
    TFaturamentoImpostosModelCliente.New.Consultar(FParametros.CodigoDoCliente, '', False, FParametros.ClienteConsumidorFinal, FParametrosClienteConsumidor);
end;

procedure TRegrasAliquotasDeRetencao.CarregarRetencaoPessoaJuridica(
  const AOrgaoPublico: Boolean);
begin
  If Not AOrgaoPublico Then
  begin
    CarregarValoresConfiguracoesAliquotasRetencaoPessoaJuridicaNaoOrgaoPublico;
    Exit;
  end;

  CarregarAliquotasCliente;
  CarregarValoresConfiguracoesProdutosAliquotasOrgaoPublico;

  FAliquotaIRF    := ValidarSeDeveZerarOrgaoPublicoValoresAliquotaIRF;
  FAliquotaPIS    := ValidarSeDeveZerarOrgaoPublicoValoresAliquotaPIS;
  FAliquotaCOFINS := ValidarSeDeveZerarOrgaoPublicoValoresAliquotaCofins;
  FAliquotaCSL    := ValidarSeDeveZerarOrgaoPublicoValoresAliquotaCSL;
end;

function TRegrasAliquotasDeRetencao.ClientePessoaJuridica: Boolean;
begin
  Result := (Length(FModelCliente.ClienteC_G_C_) > 11);
end;

constructor TRegrasAliquotasDeRetencao.Create(AParametros: IParametrosAliquotasDeRetencao);
begin
  FParametros       := AParametros;
  FCodigoDoCliente  := AParametros.CodigoDoCliente;
end;


class function TRegrasAliquotasDeRetencao.New(
  AParametros: IParametrosAliquotasDeRetencao): IRegrasAliquotasRetencao;
begin
  Result := Self.Create(AParametros);
end;


function TRegrasAliquotasDeRetencao.RetonarAliquotaCofins: Double;
begin
  Result := FAliquotaCOFINS;

  If Result > 0 Then
    Exit;

  Result := objConfiguracoes.fGetValorConfiguracao(CFG_SERVICO_ORGAO_PUBLICO_ALIQUOTA_COFINS, varDouble);
end;

function TRegrasAliquotasDeRetencao.RetonarAliquotaCSL: Double;
begin
  Result := FAliquotaCSL;

  If Result > 0 Then
    Exit;

  Result := objConfiguracoes.fGetValorConfiguracao(CFG_SERVICO_ORGAO_PUBLICO_ALIQUOTA_CSLL, varDouble);
end;

function TRegrasAliquotasDeRetencao.RetonarAliquotaIRF: Double;
begin
  Result := FAliquotaIRF;

  If Result > 0 Then
    Exit;

  Result := objConfiguracoes.fGetValorConfiguracao(CFG_SERVICO_ORGAO_PUBLICO_ALIQUOTA_IRPJ, varDouble);
end;

function TRegrasAliquotasDeRetencao.RetonarAliquotaPIS: Double;
begin
  Result := FAliquotaPIS;

  If Result > 0 Then
    Exit;

  Result := objConfiguracoes.fGetValorConfiguracao(CFG_SERVICO_ORGAO_PUBLICO_ALIQUOTA_PIS, varDouble);
end;

function TRegrasAliquotasDeRetencao.UtilizarModelCliente(
  Const AParametros: IResultadoFaturamentoImpostosModelClienteFornecedor;
  Const AParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor = Nil): IRegrasAliquotasRetencao;
begin
  Result := Self;
  FModelCliente := AParametros;
  FParametrosClienteConsumidor := AParametrosClienteConsumidor;
end;

function TRegrasAliquotasDeRetencao.ValidarRetencaoPessoaJuridica: Boolean;
begin
  Result := False;

  If Not ClientePessoaJuridica Then
    Exit;

  Result := true;

  If ValidarSeDeveCalcularAliquotaIRF Then
    Exit;

  If ValidarSeDeveCalcularAliquotaPisCofins Then
    Exit;

  Result := false;
end;

function TRegrasAliquotasDeRetencao.ValidaSeCalculaRetencoesParaSimplesNacional: Boolean;
begin
  Result := True;

  If Not objConfiguracoes.fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, VarBoolean) Then
    Exit;

  If Not objConfiguracoes.fGetValorConfiguracao(CFG_EXIBIR_NAO_SERA_REALIZADA_RETENCAO_CADASTRO_CLIENTE_EMPRESA_SIMPLES, VarBoolean) Then
    Exit;

  Result := false;
end;

Exports
  CarregarAliquotasRetencao;

end.
