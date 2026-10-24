unit Contabilidade.Classes.ApuracaoLucroPresumidoFactory;

interface

uses Contabilidade.Interfaces.ApuracaoLucroPresumido,
     Contabilidade.Interfaces.SharedLucroPresumido ;

type
  TFactoryApuracaoLucroPresumidoSalva = Class(TInterfacedObject, IFactoryApuracaoLucroPresumidoSalva)
  public
    class function New: IFactoryApuracaoLucroPresumidoSalva;
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoSalva;
  end ;

  TFactoryApuracaoLucroPresumidoCarrega = Class(TInterfacedObject, IFactoryApuracaoLucroPresumidoCarrega)
  public
    class function New: IFactoryApuracaoLucroPresumidoCarrega;
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoCarrega;
  end ;

  TFactoryApuracaoLucroPresumidoDelete = Class(TInterfacedObject, IFactoryApuracaoLucroPresumidoDelete)
  public
    class function New: IFactoryApuracaoLucroPresumidoDelete;
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoDelete;
  end ;

  TFactoryApuracaoLucroPresumidoProcessaCalculos = Class(TInterfacedObject, IFactoryApuracaoLucroPresumidoProcessaCalculos)
  public
    class function New: IFactoryApuracaoLucroPresumidoProcessaCalculos;
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoProcessaCalculos;
  end ;

  TFactoryLinhasSemEdicao = Class(TInterfacedObject, IFactoryLinhasSemEdicao)
  public
    class function New: IFactoryLinhasSemEdicao;
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoLinhasSemEdicao;
  end ;

  TFactoryLinhasSemInformacao = class(TInterfacedObject, IFactoryLinhasSemInformacao)
  public
    class function New: TFactoryLinhasSemInformacao;
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoLinhasSemInformacao;
  end ;

implementation

uses
  Contabilidade.Classes.ApuracaoLucroPresumidoCsll,
  Contabilidade.Classes.ApuracaoLucroPresumidoIrpj ;

{ TFactoryApuracaoLucroPresumidoSalva }

function TFactoryApuracaoLucroPresumidoSalva.fConfigura(
  ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoSalva;
begin
  Result := Nil ;
  if ATipo = tlpIRPJ then
    Result := TTipoApuracaoLucroPresumidoSalvaIrpj.Create
  else if ATipo = tlpCSLL then
    Result := TTipoApuracaoLucroPresumidoSalvaCsll.Create ;
end;

class function TFactoryApuracaoLucroPresumidoSalva.New: IFactoryApuracaoLucroPresumidoSalva;
begin
  Result := Self.Create ;
end;

{ TFactoryApuracaoLucroPresumidoCarrega }

function TFactoryApuracaoLucroPresumidoCarrega.fConfigura(
  ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoCarrega;
begin
  Result := Nil ;
  if ATipo = tlpIRPJ then
    Result := TTipoApuracaoLucroPresumidoCarregaIrpj.Create
  else if ATipo = tlpCSLL then
    Result := TTipoApuracaoLucroPresumidoCarregaCsll.Create ;
end;

class function TFactoryApuracaoLucroPresumidoCarrega.New: IFactoryApuracaoLucroPresumidoCarrega;
begin
  Result := Self.Create ;
end;

{ TFactoryApuracaoLucroPresumidoProcessaCalculos }

function TFactoryApuracaoLucroPresumidoProcessaCalculos.fConfigura(
  ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Nil ;
  if ATipo = tlpIRPJ then
    Result := TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.Create
  else if ATipo = tlpCSLL then
    Result := TTipoApuracaoLucroPresumidoProcessaCalculosCsll.Create ;
end;

class function TFactoryApuracaoLucroPresumidoProcessaCalculos.New: IFactoryApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Self.Create ;
end;

{ TFactoryLinhasSemEdicao }

function TFactoryLinhasSemEdicao.fConfigura(
  ATipo: TTipoLucroPresumido): ITipoLinhasSemEdicao;
begin
  Result := Nil ;
  if ATipo = tlpIRPJ then
    Result := TTipoLinhasSemEdicaoIrpj.New
  else if ATipo = tlpCSLL then
    Result := TTipoLinhasSemEdicaoCsll.New ;
end;

class function TFactoryLinhasSemEdicao.New: IFactoryLinhasSemEdicao;
begin
  Result := Self.Create ;
end;

{ TFactoryLinhasSemInformacao }

function TFactoryLinhasSemInformacao.fConfigura(
  ATipo: TTipoLucroPresumido): ITipoLinhasSemInformacao;
begin
  Result := Nil ;
  if ATipo = tlpIRPJ then
    Result := TTipoLinhasSemInformacaoIrpj.Create
  else if ATipo = tlpCSLL then
    Result := TTipoLinhasSemInformacaoCsll.Create ;
end;

class function TFactoryLinhasSemInformacao.New: TFactoryLinhasSemInformacao;
begin
  Result := Self.Create ;
end;

{ TFactoryApuracaoLucroPresumidoDelete }

function TFactoryApuracaoLucroPresumidoDelete.fConfigura(
  ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoDelete;
begin
  Result := Nil ;
  if ATipo = tlpIRPJ then
    Result := TTipoApuracaoLucroPresumidoDeleteIrpj.Create
  else if ATipo = tlpCSLL then
    Result := TTipoApuracaoLucroPresumidoDeleteCsll.Create ;
end;

class function TFactoryApuracaoLucroPresumidoDelete.New: IFactoryApuracaoLucroPresumidoDelete;
begin
  Result := Self.Create ;
end;

end.
