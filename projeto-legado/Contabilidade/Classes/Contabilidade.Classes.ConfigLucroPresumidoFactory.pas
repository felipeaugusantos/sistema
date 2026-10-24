unit Contabilidade.Classes.ConfigLucroPresumidoFactory;

interface

uses Contabilidade.Interfaces.ConfigLucroPresumido,
     Contabilidade.Interfaces.SharedLucroPresumido ;

type
  TFactoryConfigLucroPresumidoSalva = Class(TInterfacedObject, IFactoryConfigLucroPresumidoSalva)
  public
    class function New: IFactoryConfigLucroPresumidoSalva;
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoSalva;
  end ;

  TFactoryConfigLucroPresumidoCarrega = Class(TInterfacedObject, IFactoryConfigLucroPresumidoCarrega)
  public
    class function New: IFactoryConfigLucroPresumidoCarrega;
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoCarrega;
  end ;

  TFactoryConfigLucroPresumidoDelete = Class(TInterfacedObject, IFactoryConfigLucroPresumidoDelete)
  public
    class function New: IFactoryConfigLucroPresumidoDelete;
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoDelete;
  end ;

  TFactoryConfigLucroPresumidoClona = Class(TInterfacedObject, IFactoryConfigLucroPresumidoClona)
  public
    class function New: IFactoryConfigLucroPresumidoClona;
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoClona;
  end ;

  TFactoryConfigLucroPresumidoCadastroTabelaApuracaoBC = Class(TInterfacedObject, IFactoryConfigLucroPresumidoCadastroTabelaApuracaoBC)
  public
    class function New: IFactoryConfigLucroPresumidoCadastroTabelaApuracaoBC;
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoCadastroTabelaApuracaoBC;
  end ;

implementation

uses Contabilidade.Classes.ConfigLucroPresumidoIrpj, Contabilidade.Classes.ConfigLucroPresumidoCsll ;

{ TFactoryConfigLucroPresumidoCarrega }

function TFactoryConfigLucroPresumidoCarrega.fConfigura(
  ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoCarrega;
begin
  Result := Nil ;
  if ATipo = tlpIRPJ then
    Result := TTipoConfigLucroPresumidoCarregaIrpj.Create
  else if ATipo = tlpCSLL then
    Result := TTipoConfigLucroPresumidoCarregaCsll.Create ;
end;

class function TFactoryConfigLucroPresumidoCarrega.New: IFactoryConfigLucroPresumidoCarrega;
begin
  Result := Self.Create;
end;

{ TFactoryConfigLucroPresumidoSalva }

function TFactoryConfigLucroPresumidoSalva.fConfigura(
  ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoSalva;
begin
  Result := Nil ;
  if ATipo = tlpIRPJ then
    Result := TTipoConfigLucroPresumidoSalvaIrpj.Create
  else if ATipo = tlpCSLL then
    Result := TTipoConfigLucroPresumidoSalvaCsll.Create ;
end;

class function TFactoryConfigLucroPresumidoSalva.New: IFactoryConfigLucroPresumidoSalva;
begin
  Result := Self.Create;
end;

{ TFactoryConfigLucroPresumidoDelete }

function TFactoryConfigLucroPresumidoDelete.fConfigura(
  ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoDelete;
begin
  Result := Nil ;
  if ATipo = tlpIRPJ then
    Result := TTipoConfigLucroPresumidoDeleteIrpj.Create
  else if ATipo = tlpCSLL then
    Result := TTipoConfigLucroPresumidoDeleteCsll.Create ;
end;

class function TFactoryConfigLucroPresumidoDelete.New: IFactoryConfigLucroPresumidoDelete;
begin
  Result := Self.Create;
end;

{ TFactoryConfigLucroPresumidoClona }

function TFactoryConfigLucroPresumidoClona.fConfigura(
  ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoClona;
begin
  Result := Nil ;
  if ATipo = tlpIRPJ then
    Result := TTipoConfigLucroPresumidoClonaIrpj.Create
  else if ATipo = tlpCSLL then
    Result := TTipoConfigLucroPresumidoClonaCsll.Create ;
end;

class function TFactoryConfigLucroPresumidoClona.New: IFactoryConfigLucroPresumidoClona;
begin
  Result := Self.Create;
end;

{ TFactoryConfigLucroPresumidoCadastroTabelaApuracaoBC }

function TFactoryConfigLucroPresumidoCadastroTabelaApuracaoBC.fConfigura(
  ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoCadastroTabelaApuracaoBC;
begin
  Result := Nil ;
  if ATipo = tlpIRPJ then
    Result := TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCIrpj.Create
  else if ATipo = tlpCSLL then
    Result := TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCCsll.Create ;
end;

class function TFactoryConfigLucroPresumidoCadastroTabelaApuracaoBC.New: IFactoryConfigLucroPresumidoCadastroTabelaApuracaoBC;
begin
  Result := Self.Create ;
end;

end.
