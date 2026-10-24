unit Faturamento.Impostos.Calculos.IcmsOrgaoPublico;

interface

uses Faturamento.Impostos.Interfaces.IcmsOrgaoPublico,
  Faturamento.Impostos.Tipos.IcmsOrgaoPublico,
  Shared.Functions.Core, System.StrUtils,
  Shared.Functions.Funcoes.Faturamento;

type
  TCalculoImpostosIcmsOrgaoPublico = class(TInterfacedObject, ICalculoImpostosIcmsOrgaoPublico)
  private
    FValorDoIcmsDeOrgaoPublicoDoItem: Double;
    FBaseDeIcmsDeOrgaoPublicoDoItem: Double;
    FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double;
    FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double;
    FAliquotaDeIcmsDoItem: Double;
    FValorSeparadoDoIcmsDeOrgaoPublicoDoItem: Double;
    FValorSeparadoDoPisDeOrgaoPublicoDoItem: Double;
    FValorSeparadoDoCofinsDeOrgaoPublicoDoItem: Double;
    FAliquotaDoIcmsDeOrgaoPublicoDoItem: Double;
    FAliquotaDoPisDeOrgaoPublicoDoItem: Double;
    FAliquotaDoCofinsDeOrgaoPublicoDoItem: Double;
    FIsencaoDeIcmsVendasZonaFrancaProdutosNacionaisQueIniciamComCST: String;

    FParametros: IParametrosCalculoIcmsOrgaoPublico;

    function CalculaDescontoIcmsOrgaoPublicoForaDoEstado: Boolean;
    function ClienteZonaFrancaNaoClienteConsumidorFinal: Boolean;
    function IsencaoDeIcmsVendasZonaFrancaProdutosNacionais: Boolean;
    function ClienteOrgaoPublicoOuClienteZonaFrancaNaoClienteConsumidorFinal: Boolean;
    procedure ClienteOrgaoPublicoCalcularDescontoOuClienteZonaFrancaNaoClienteConsumidorFinal;
    function IsencaoDeIcmsVendasZonaFrancaProdutosNacionaisClienteZonaFrancaNaoClienteConsumidorFinal: Boolean;
    procedure CalcularBaseDeIcmsDeOrgaoPublicoConfirmacao;
    procedure CalcularValorDeIcmsDeOrgaoPublicoConfirmacao;
    procedure CalcularValorEBaseIcmsOrgaoPublico;
    function PermitidoCalcularValorEBaseIcmsOrgaoPublico: Boolean;
    function NaoEhSubstituicaoTributariaENaoEhIsencaoDeIcmsClienteZonaFranca: Boolean;
    function ClienteZonaFrancaNaoClienteConsumidorFinalENaoEhIsencaoDeIcmsVendas: Boolean;

    procedure ClienteOrgaoPublicoAplicarDescontoPisCofins;
    function RetornaBaseDeCalculoIcmsOrgaoPublico: Double;

    procedure IniciandoAsVariaveis(AParametros: IParametrosCalculoIcmsOrgaoPublico);
    procedure CalcularDentroOuForaDoEstado;
    procedure ClienteOrgaoPublicoCalcularIcmsParaDocumentosDeConfirmacao;
    procedure CalcularIcmsOrgaoPublico;

    procedure CalcularDentroDoEstado;
    procedure CalcularForaDoEstado;
    function ResultadoDoCalculo: IResultadoCalculoIcmsOrgaoPublico;
    function RetornarValorDoIpiDoItem: double;
    function TotalDoItemParaBaseDeCalculoDoImposto: Double;
    function EhCstEstrangeiraSemSimilarNacional : Boolean;
    function EhCstTributacaoZonaFranca : Boolean;
    function CstTributaEmZonaFranca : Boolean;
  public
    function CalcularValorIcmsOrgaoPublico(AParametros: IParametrosCalculoIcmsOrgaoPublico): IResultadoCalculoIcmsOrgaoPublico;
    class function New(): ICalculoImpostosIcmsOrgaoPublico;
  end;

//  function CalcularValorIcmsOrgaoPublico(AParametros: IParametrosCalculoIcmsOrgaoPublico): IResultadoCalculoIcmsOrgaoPublico; stdcall;

implementation

uses Shared.Functions.Configuracoes, System.SysUtils;

//function CalcularValorIcmsOrgaoPublico(AParametros: IParametrosCalculoIcmsOrgaoPublico): IResultadoCalculoIcmsOrgaoPublico; stdcall;
//begin
//  Result := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);
//end;

{ TCalculoImpostosIcmsOrgaoPublico }

procedure TCalculoImpostosIcmsOrgaoPublico.CalcularBaseDeIcmsDeOrgaoPublicoConfirmacao;
begin
  If Not PermitidoCalcularValorEBaseIcmsOrgaoPublico Then
    Exit;

  FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao := RetornaBaseDeCalculoIcmsOrgaoPublico;
end;

procedure TCalculoImpostosIcmsOrgaoPublico.CalcularDentroDoEstado;
begin
  ClienteOrgaoPublicoAplicarDescontoPisCofins;

  ClienteOrgaoPublicoCalcularIcmsParaDocumentosDeConfirmacao;

  ClienteOrgaoPublicoCalcularDescontoOuClienteZonaFrancaNaoClienteConsumidorFinal;
end;

procedure TCalculoImpostosIcmsOrgaoPublico.CalcularForaDoEstado;
begin
  ClienteOrgaoPublicoAplicarDescontoPisCofins;

  If Not ClienteZonaFrancaNaoClienteConsumidorFinal Then
    Exit;

  If IsencaoDeIcmsVendasZonaFrancaProdutosNacionais Then
    Exit;

  If EhCstTributacaoZonaFranca Then
    Exit;

  CalcularIcmsOrgaoPublico;
end;

procedure TCalculoImpostosIcmsOrgaoPublico.CalcularIcmsOrgaoPublico;
begin
  FBaseDeIcmsDeOrgaoPublicoDoItem := RetornaBaseDeCalculoIcmsOrgaoPublico;
  FAliquotaDoIcmsDeOrgaoPublicoDoItem := FAliquotaDeIcmsDoItem;
  FValorSeparadoDoIcmsDeOrgaoPublicoDoItem := objCore.fFormataFloat((FBaseDeIcmsDeOrgaoPublicoDoItem * FAliquotaDeIcmsDoItem) / 100, 2);
  FValorDoIcmsDeOrgaoPublicoDoItem := FValorDoIcmsDeOrgaoPublicoDoItem + FValorSeparadoDoIcmsDeOrgaoPublicoDoItem;
end;

procedure TCalculoImpostosIcmsOrgaoPublico.CalcularValorDeIcmsDeOrgaoPublicoConfirmacao;
begin
  FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao := FParametros.DescontoEspecialDoItem;
end;

procedure TCalculoImpostosIcmsOrgaoPublico.CalcularValorEBaseIcmsOrgaoPublico;
begin
  If Not PermitidoCalcularValorEBaseIcmsOrgaoPublico Then
    Exit;

  CalcularIcmsOrgaoPublico;
end;

function TCalculoImpostosIcmsOrgaoPublico.CalcularValorIcmsOrgaoPublico(
  AParametros: IParametrosCalculoIcmsOrgaoPublico): IResultadoCalculoIcmsOrgaoPublico;
begin
  IniciandoAsVariaveis(AParametros);

  CalcularDentroOuForaDoEstado;

  Result := ResultadoDoCalculo;
end;

procedure TCalculoImpostosIcmsOrgaoPublico.ClienteOrgaoPublicoAplicarDescontoPisCofins;
begin
  If Not ClienteOrgaoPublicoOuClienteZonaFrancaNaoClienteConsumidorFinal Then
    Exit;

  If FParametros.SubstituicaoTributariaDoItem Then
    Exit;

  If Not FParametros.AplicarDescontoPisCofinsOrgaoPublico Then
    Exit;

  FAliquotaDoPisDeOrgaoPublicoDoItem := FParametros.AliquotaDoPis;
  FAliquotaDoCofinsDeOrgaoPublicoDoItem := FParametros.AliquotaDoCofins;

  FValorSeparadoDoPisDeOrgaoPublicoDoItem := objCore.fFormataFloat((TotalDoItemParaBaseDeCalculoDoImposto * FParametros.AliquotaDoPis) / 100, 2);
  FValorSeparadoDoCofinsDeOrgaoPublicoDoItem := objCore.fFormataFloat((TotalDoItemParaBaseDeCalculoDoImposto * FParametros.AliquotaDoCofins) / 100, 2);

  FValorDoIcmsDeOrgaoPublicoDoItem := FValorSeparadoDoPisDeOrgaoPublicoDoItem;
  FValorDoIcmsDeOrgaoPublicoDoItem := FValorDoIcmsDeOrgaoPublicoDoItem + FValorSeparadoDoCofinsDeOrgaoPublicoDoItem;
end;

procedure TCalculoImpostosIcmsOrgaoPublico.ClienteOrgaoPublicoCalcularDescontoOuClienteZonaFrancaNaoClienteConsumidorFinal;
begin
  If Not TFunctionFuncoesFaturamento.ClienteZonaFrancaOrgaoPublico(FParametros.ClienteOrgaoPublico,
    FParametros.CalcularDescontoIcmsOrgaoPublico, FParametros.ClienteZonaFranca, FParametros.ClienteConsumidorFinal) Then
    Exit;

  CalcularValorEBaseIcmsOrgaoPublico;
end;

procedure TCalculoImpostosIcmsOrgaoPublico.ClienteOrgaoPublicoCalcularIcmsParaDocumentosDeConfirmacao;
begin
  If Not TFunctionFuncoesFaturamento.DocumentosDeConfirmacaoClienteOrgaoPublicoNaoCalcularIcms(
    FParametros.OpcaoDeDocumento, FParametros.ClienteOrgaoPublico, FParametros.CalcularDescontoIcmsOrgaoPublico) Then
    Exit;

  CalcularBaseDeIcmsDeOrgaoPublicoConfirmacao;

  CalcularValorDeIcmsDeOrgaoPublicoConfirmacao;
end;

function TCalculoImpostosIcmsOrgaoPublico.ClienteOrgaoPublicoOuClienteZonaFrancaNaoClienteConsumidorFinal: Boolean;
begin
  Result := True;

  If FParametros.ClienteOrgaoPublico Then
    Exit;

  If ClienteZonaFrancaNaoClienteConsumidorFinal Then
    Exit;

  Result := False;
end;

function TCalculoImpostosIcmsOrgaoPublico.CalculaDescontoIcmsOrgaoPublicoForaDoEstado: Boolean;
begin
  Result := False;

  If not FParametros.ClienteOrgaoPublico Then
    Exit;

  If not FParametros.CalcularDescontoIcmsOrgaoPublico Then
    Exit;

  If not FParametros.OrgaoPublicoForaDoEstado Then
    Exit;

  Result := True;
end;

function TCalculoImpostosIcmsOrgaoPublico.ClienteZonaFrancaNaoClienteConsumidorFinal: Boolean;
begin
  Result := False;

  If CalculaDescontoIcmsOrgaoPublicoForaDoEstado Then
    Exit(True);

  If Not FParametros.ClienteZonaFranca Then
    Exit;

  If FParametros.ClienteConsumidorFinal Then
    Exit;

  Result := True;
end;

function TCalculoImpostosIcmsOrgaoPublico.ClienteZonaFrancaNaoClienteConsumidorFinalENaoEhIsencaoDeIcmsVendas: Boolean;
begin
  Result := False;

  If Not FParametros.SubstituicaoTributariaDoItem Then
    Exit;

  If Not ClienteZonaFrancaNaoClienteConsumidorFinal Then
    Exit;

  If IsencaoDeIcmsVendasZonaFrancaProdutosNacionais Then
    Exit;

  Result := True;
end;

function TCalculoImpostosIcmsOrgaoPublico.NaoEhSubstituicaoTributariaENaoEhIsencaoDeIcmsClienteZonaFranca: Boolean;
begin
  Result := False;

  If FParametros.SubstituicaoTributariaDoItem Then
    Exit;

  If IsencaoDeIcmsVendasZonaFrancaProdutosNacionaisClienteZonaFrancaNaoClienteConsumidorFinal Then
    Exit;

  Result := True;
end;

class function TCalculoImpostosIcmsOrgaoPublico.New: ICalculoImpostosIcmsOrgaoPublico;
begin
  Result := Self.Create;
end;

function TCalculoImpostosIcmsOrgaoPublico.PermitidoCalcularValorEBaseIcmsOrgaoPublico: Boolean;
begin
  Result := True;

  If NaoEhSubstituicaoTributariaENaoEhIsencaoDeIcmsClienteZonaFranca Then
    Exit;

  If ClienteZonaFrancaNaoClienteConsumidorFinalENaoEhIsencaoDeIcmsVendas Then
    Exit;

  Result := False;

end;

function TCalculoImpostosIcmsOrgaoPublico.ResultadoDoCalculo: IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := TResultadoCalculoIcmsOrgaoPublico.Create;
  Result.ValorDoIcmsDeOrgaoPublicoDoItem(FValorDoIcmsDeOrgaoPublicoDoItem);
  Result.BaseDeIcmsDeOrgaoPublicoDoItem(FBaseDeIcmsDeOrgaoPublicoDoItem);
  Result.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao);
  Result.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao);
  Result.ValorSeparadoDoIcmsDeOrgaoPublicoDoItem(FValorSeparadoDoIcmsDeOrgaoPublicoDoItem);
  Result.ValorSeparadoDoPisDeOrgaoPublicoDoItem(FValorSeparadoDoPisDeOrgaoPublicoDoItem);
  Result.ValorSeparadoDoCofinsDeOrgaoPublicoDoItem(FValorSeparadoDoCofinsDeOrgaoPublicoDoItem);
  Result.AliquotaDoIcmsDeOrgaoPublicoDoItem(FAliquotaDoIcmsDeOrgaoPublicoDoItem);
  Result.AliquotaDoPisDeOrgaoPublicoDoItem(FAliquotaDoPisDeOrgaoPublicoDoItem);
  Result.AliquotaDoCofinsDeOrgaoPublicoDoItem(FAliquotaDoCofinsDeOrgaoPublicoDoItem);
end;

function TCalculoImpostosIcmsOrgaoPublico.TotalDoItemParaBaseDeCalculoDoImposto: Double;
begin
  Result := FParametros.ValorTotalDoItem;
  If (FParametros.ConsideraDescontoNaBaseDeCalculo) Then
    Result := Result - FParametros.DescontoEspecialDoItem;
End;

function TCalculoImpostosIcmsOrgaoPublico.RetornaBaseDeCalculoIcmsOrgaoPublico: Double;
begin
  Result := objCore.fFormataFloat((( (TotalDoItemParaBaseDeCalculoDoImposto + FParametros.ValorFreteDespesasAcessoriasItem + RetornarValorDoIpiDoItem) * FParametros.PercentualDaBaseDeCalculoDoItem) / 100), 2);
end;

procedure TCalculoImpostosIcmsOrgaoPublico.CalcularDentroOuForaDoEstado;
begin
  If FParametros.DentroDoEstado Then
  Begin
    CalcularDentroDoEstado;
    Exit;
  End;

  CalcularForaDoEstado;
end;

procedure TCalculoImpostosIcmsOrgaoPublico.IniciandoAsVariaveis(
  AParametros: IParametrosCalculoIcmsOrgaoPublico);
begin
  FAliquotaDoIcmsDeOrgaoPublicoDoItem := 0;
  FAliquotaDoPisDeOrgaoPublicoDoItem := 0;
  FAliquotaDoCofinsDeOrgaoPublicoDoItem := 0;

  FValorSeparadoDoIcmsDeOrgaoPublicoDoItem := 0;
  FValorSeparadoDoPisDeOrgaoPublicoDoItem := 0;
  FValorSeparadoDoCofinsDeOrgaoPublicoDoItem := 0;

  FValorDoIcmsDeOrgaoPublicoDoItem := 0;
  FBaseDeIcmsDeOrgaoPublicoDoItem := 0;

  FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao := 0;
  FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao := 0;

  FAliquotaDeIcmsDoItem := AParametros.AliquotaDeIcmsDoItem;

  FIsencaoDeIcmsVendasZonaFrancaProdutosNacionaisQueIniciamComCST :=
    TFunctionFuncoesFaturamento.Transform(objConfiguracoes.fGetValorConfiguracao(CFG_ISENCAO_ICMS_VENDAS_ZONA_FRANCA_SOMENTE_PARA_PRODUTOS_NACIONAIS_QUE_INICIAM_COM_CST),1);

  FParametros := AParametros;
end;

function TCalculoImpostosIcmsOrgaoPublico.IsencaoDeIcmsVendasZonaFrancaProdutosNacionais: Boolean;
begin
  Result := False;

  If Not FParametros.IsencaoDeIcmsVendasZonaFrancaProdutosNacionais Then
    Exit;

  If (Pos(LeftStr(FParametros.CodigoDaSituacaoTributaria, 1), FIsencaoDeIcmsVendasZonaFrancaProdutosNacionaisQueIniciamComCST) > 0) Then
    Exit;

  Result := True;
end;

function TCalculoImpostosIcmsOrgaoPublico.IsencaoDeIcmsVendasZonaFrancaProdutosNacionaisClienteZonaFrancaNaoClienteConsumidorFinal: Boolean;
begin
  Result := False;

  If Not FParametros.IsencaoDeIcmsVendasZonaFrancaProdutosNacionais Then
    Exit;

  If (Pos(LeftStr(FParametros.CodigoDaSituacaoTributaria, 1), FIsencaoDeIcmsVendasZonaFrancaProdutosNacionaisQueIniciamComCST) > 0) Then
    Exit;

  If Not FParametros.ClienteZonaFranca Then
    Exit;

  If FParametros.ClienteConsumidorFinal Then
    Exit;

  Result := True;
end;

function TCalculoImpostosIcmsOrgaoPublico.CstTributaEmZonaFranca : Boolean;
  Var
    LCstsQueTributam : String;
begin
  LCstsQueTributam := Trim(TFunctionFuncoesFaturamento.Transform(objConfiguracoes.fGetValorConfiguracao(CFG_ZONA_FRANCA_DE_MANAUS_TRIBUTAR_PRODUTOS_QUE_INICIAM_COM_A_CST, varString) + ' ', 1));
  Result := (Pos(LeftStr(FParametros.CodigoDaSituacaoTributaria, 1), LCstsQueTributam) > 0);
end;

function TCalculoImpostosIcmsOrgaoPublico.EhCstEstrangeiraSemSimilarNacional : Boolean;
begin
  Result := (Pos(LeftStr(FParametros.CodigoDaSituacaoTributaria, 1), '6_7_') > 0);
end;

function TCalculoImpostosIcmsOrgaoPublico.EhCstTributacaoZonaFranca : Boolean;
begin
  Result := False;

  If (Not FParametros.ClienteZonaFranca) Then
    Exit;

  If EhCstEstrangeiraSemSimilarNacional Then
    Exit(True);

  If (Not CstTributaEmZonaFranca) Then
    Exit;

  Result := True;
end;

function TCalculoImpostosIcmsOrgaoPublico.RetornarValorDoIpiDoItem: double;
begin
  result := 0;

  If not FParametros.EntraIPINaBaseIcms Then
    Exit;

  result := FParametros.ValorDoIpiDoItem;
end;

//exports CalcularValorIcmsOrgaoPublico;

end.
