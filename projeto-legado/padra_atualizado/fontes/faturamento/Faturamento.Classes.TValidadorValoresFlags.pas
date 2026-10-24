unit Faturamento.Classes.TValidadorValoresFlags;

interface

uses
  Windows, Uni, untFuncoes, untFuncoesSimples, Forms, Sysutils, ExtCtrls,
  untFuncFat, untFuncFatTypes;

type
  {$M+}
  TValidadorValoresFlags = class
  strict private
    var
      strRetornoCliente: string;
      strRetornoProduto: string;

    FOwner: TFatVenda;
    FMensagemRetorno: string;

    function ValidarFlag(const strValorFlag: string): boolean;
    procedure ConcatenaMensagem(const strNomeCampo: string; var strMensagem: string);
    procedure Valida(const strNomeCampo, strValorFlag: string; var strMensagem: string);

    procedure ValidaFlagOrgaoPublico;
    procedure ValidaFlagZonaFranca;
    procedure ValidaFlagConsumidorFinal;
    procedure ValidaFlagDescontoPISeCOFINS;
    procedure ValidaFlagCalculaDescontoIcms;
    procedure ValidaFlagMEIMicroEmpreendedorIndividual;

    procedure ValidaFlagImportacaoDireta(objItem: TDadosFechamento);
    procedure ValidaFlagUtilizaDecretoReducaoPR(objItem: TDadosFechamento);

    procedure ValidaFlagsCliente;
    procedure ValidaFlagsItens;

    function ValidarEspecie: boolean;

    function Execute: boolean; overload;
    constructor Create(AOwner: TFatVenda); overload;

    function VerificarSeConfiguracaoValidarFlagsEstaAtiva: boolean;
    function VerificarConfiguracaoItemDeServico(objItem: TDadosFechamento): boolean;
    function VerificarServicosNaoTerceirizados(objItem: TDadosFechamento): boolean;
    function VerificarServicosTerceirizadosAutoCenter(objItem: TDadosFechamento): boolean;
  published
    property MensagemRetorno: string read FMensagemRetorno;
  public
    class function Execute(AOwner: TFatVenda; out strMensagemRetorno: string): boolean; overload;
    constructor Create; reintroduce; overload;
  end;
  {$M-}

implementation

{ TValidadorValoresFlags }

procedure TValidadorValoresFlags.ConcatenaMensagem(
  const strNomeCampo: string; var strMensagem: string);
begin
  if (not strMensagem.IsEmpty) then
    strMensagem := strMensagem + sLineBreak;
  strMensagem := strMensagem + strNomeCampo;
end;

constructor TValidadorValoresFlags.Create;
const
  strMENSAGEM_ERRO_CONSTRUTOR = 'Construtor inválido da classe %s';
begin
  raise Exception.Create(Format(strMENSAGEM_ERRO_CONSTRUTOR, [Self.ClassName]));
end;

constructor TValidadorValoresFlags.Create(AOwner: TFatVenda);
begin
  inherited Create;
  FOwner := AOwner;
  FMensagemRetorno := String.Empty;
end;

procedure TValidadorValoresFlags.Valida(const strNomeCampo, strValorFlag: string;
  var strMensagem: string);
begin
  if ValidarFlag(strValorFlag) then
    Exit;
  ConcatenaMensagem(strNomeCampo, strMensagem);
end;

procedure TValidadorValoresFlags.ValidaFlagCalculaDescontoIcms;
const
  strNOME_CAMPO = '    - Calcula Desconto Icms;';
begin
  Valida(strNOME_CAMPO, FOwner.strCalIcm, strRetornoCliente);
end;

procedure TValidadorValoresFlags.ValidaFlagConsumidorFinal;
const
  strNOME_CAMPO = '    - Consumidor Final;';
begin
  Valida(strNOME_CAMPO, FOwner.strCliCon, strRetornoCliente);
end;

procedure TValidadorValoresFlags.ValidaFlagDescontoPISeCOFINS;
const
  strNOME_CAMPO = '    - Aplicar desconto de PIS/COFINS;';
begin
  Valida(strNOME_CAMPO, FOwner.strDesPis, strRetornoCliente);
end;

procedure TValidadorValoresFlags.ValidaFlagMEIMicroEmpreendedorIndividual;
const
  strNOME_CAMPO = '    - MEI - Micro Empreendedor Individual;';
begin
  Valida(strNOME_CAMPO, FOwner.strMicEmp, strRetornoCliente);
end;

procedure TValidadorValoresFlags.ValidaFlagOrgaoPublico;
const
  strNOME_CAMPO = '    - Órgão Público;';
begin
  Valida(strNOME_CAMPO, FOwner.strCliOrg, strRetornoCliente);
end;

procedure TValidadorValoresFlags.ValidaFlagZonaFranca;
const
  strNOME_CAMPO = '    - Zona Franca;';
begin
  Valida(strNOME_CAMPO, FOwner.strZonFra, strRetornoCliente);
end;

procedure TValidadorValoresFlags.ValidaFlagsCliente;
begin
  strRetornoCliente := String.Empty;
  ValidaFlagOrgaoPublico;
  ValidaFlagZonaFranca;
  ValidaFlagConsumidorFinal;
  ValidaFlagDescontoPISeCOFINS;
  ValidaFlagCalculaDescontoIcms;
  ValidaFlagMEIMicroEmpreendedorIndividual;
  if not strRetornoCliente.IsEmpty then
    strRetornoCliente := '- Cliente (' + FOwner.strCodCli + '): ' + sLineBreak + strRetornoCliente;
end;

function TValidadorValoresFlags.ValidarEspecie: boolean;
const
  str_ESPECIES_PARA_VALIDAR = 'OR_PD_NF_FF_DV_';
begin
  result := Pos(FOwner.strEspDoc, str_ESPECIES_PARA_VALIDAR) > 0;
end;

procedure TValidadorValoresFlags.ValidaFlagsItens;
var
  objItem: TDadosFechamento;
begin
  strRetornoProduto := String.Empty;
  for objItem in FOwner.arrMatItens do
  begin
    if VerificarConfiguracaoItemDeServico(objItem) then
      Continue;

    ValidaFlagImportacaoDireta(objItem);
    ValidaFlagUtilizaDecretoReducaoPR(objItem);
  end;
  if not strRetornoProduto.IsEmpty then
    strRetornoProduto := '- Itens: ' + sLineBreak + strRetornoProduto;
end;

function TValidadorValoresFlags.ValidarFlag(const strValorFlag: string): boolean;
const
  strSIM_NAO = '_S_N';
begin
  result := Pos(strValorFlag, strSIM_NAO) > 0;
end;

procedure TValidadorValoresFlags.ValidaFlagImportacaoDireta(objItem: TDadosFechamento);
const
  strCAMPO = '    - Produto: %s - Importação Direta;';
begin
  Valida(Format(strCAMPO, [objItem.strCodIte]), objItem.strImpDir, strRetornoProduto);
end;

procedure TValidadorValoresFlags.ValidaFlagUtilizaDecretoReducaoPR(objItem: TDadosFechamento);
const
  strCAMPO = '    - Produto: %s - Utiliza Redução ICM/PR;';
begin
  Valida(Format(strCAMPO, [objItem.strCodIte]), objItem.strRICMPR, strRetornoProduto);
end;

function TValidadorValoresFlags.VerificarConfiguracaoItemDeServico(objItem: TDadosFechamento): boolean;
begin
  if VerificarServicosNaoTerceirizados(objItem) then
    Exit(True);

  if VerificarServicosTerceirizadosAutoCenter(objItem) then
    Exit(True);

  result := False;
end;

function TValidadorValoresFlags.VerificarSeConfiguracaoValidarFlagsEstaAtiva: boolean;
begin
  result := fCfgSis('VALFLG', varBoolean);
end;

function TValidadorValoresFlags.VerificarServicosNaoTerceirizados(objItem: TDadosFechamento): boolean;
begin
  result := fCfgSis('ITESER') = objItem.strCodIte;
end;

function TValidadorValoresFlags.VerificarServicosTerceirizadosAutoCenter(objItem: TDadosFechamento): boolean;
begin
  result := fCfgSis('SERTER') = objItem.strCodIte;
end;

function TValidadorValoresFlags.Execute: boolean;
begin
  if not VerificarSeConfiguracaoValidarFlagsEstaAtiva then
    Exit(True);

  if not ValidarEspecie then
    Exit(True);

  ValidaFlagsCliente;
  ValidaFlagsItens;

  FMensagemRetorno := Trim(strRetornoCliente + sLineBreak + sLineBreak + strRetornoProduto);
  result := FMensagemRetorno.IsEmpty;
end;

class function TValidadorValoresFlags.Execute(AOwner: TFatVenda; out strMensagemRetorno: string): boolean;
const
  strMENSAGEM_FLAGS_VALORES_INCONSISTENTES =
    'Foram identificados Dados Cadastrais com campos de flag N/S com valores inconsistentes para cálculos de impostos. Verifique! %s';
var
  objValidador: TValidadorValoresFlags;
begin
  Result := False;
  strMensagemRetorno := String.Empty;

  objValidador := TValidadorValoresFlags.Create(AOwner);
  try
    if objValidador.Execute then
      Exit(True);

    strMensagemRetorno := Format(strMENSAGEM_FLAGS_VALORES_INCONSISTENTES,
                                 [sLineBreak + sLineBreak + objValidador.MensagemRetorno]);
  finally
    FreeAndNil(objValidador);
  end;
end;

end.
