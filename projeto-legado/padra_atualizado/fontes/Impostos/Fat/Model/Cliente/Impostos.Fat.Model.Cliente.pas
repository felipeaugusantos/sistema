unit Impostos.Fat.Model.Cliente;

interface

uses Impostos.Fat.Model.Cliente.Interfaces, Impostos.Fat.Model.Cliente.Tipos,
  Impostos.Fat.Connections.Functions, Impostos.Fat.Conexao.Interfaces, Uni;

type
  TImpostosFatModelCliente = class sealed(TInterfacedObject, IImpostosFatModelCliente)
  private
    FConexao: TUniConnection;
  public
    function Consultar(const ACodigoDoCliente: String): IResultadoImpostosFatModelCliente;

    constructor Create;
    class function New(): IImpostosFatModelCliente;
  end;

implementation

{ TImpostosFatModelCliente }

function TImpostosFatModelCliente.Consultar(
  const ACodigoDoCliente: String): IResultadoImpostosFatModelCliente;
var
  LSituacaoDoIpi: String;
  LZonaFranca: Boolean;
  LOrgaoPublico: Boolean;
  LClienteExterior: Boolean;
  LClienteEstado: String;
  LClienteConsumidor: Boolean;

begin
  LSituacaoDoIpi        := fCampoTabelaFat('CLI_SITIPI', 'CADCLI', ['CLI_CODCLI'], [ACodigoDoCliente], False, '', FConexao);

  LZonaFranca           := fCampoTabelaFat('CLI_ZONFRA', 'CADCLI', ['CLI_CODCLI'], [ACodigoDoCliente], False, '', FConexao) = 'S';
  LOrgaoPublico         := fCampoTabelaFat('CLI_ORGPUB', 'CADCLI', ['CLI_CODCLI'], [ACodigoDoCliente], False, '', FConexao) = 'S';

  LClienteEstado        := fCampoTabelaFat('CID_ESTADO', 'CADCLI INNER JOIN CADCID ON CID_CODCID = CLI_CODCID ', ['CLI_CODCLI'], [ACodigoDoCliente], False, '', FConexao);
  LClienteExterior      := LClienteEstado = 'EX';

  LClienteConsumidor    := fCampoTabelaFat('CLI_CONSUM', 'CADCLI', ['CLI_CODCLI'], [ACodigoDoCliente], False, '', FConexao) = 'S';

  Result :=
    TResultadoImpostosFatModelCliente.New
      .SituacaoDoIpi(LSituacaoDoIpi)
      .ZonaFranca(LZonaFranca)
      .OrgaoPublico(LOrgaoPublico)
      .ClienteExterior(LClienteExterior)
      .ClienteEstado(LClienteEstado)
      .ClienteConsumidor(LClienteConsumidor);
end;

constructor TImpostosFatModelCliente.Create;
begin
  FConexao := objConexao.Conexao;
end;

class function TImpostosFatModelCliente.New(): IImpostosFatModelCliente;
begin
  Result := Self.Create;
end;

end.
