unit untTefCitelTransacaoFactory;

interface

uses
  System.SysUtils, untTefCitelTransacaoInterfaces;

type
  TTransacaoTefFactory = class(TInterfacedObject, ITransacaoTefFactory)
  private
    FstrCfgTefCit: string;

  public
    function fRepository: ITransacaoTefRepository;
    function fViewControls: ITransacaoTefViewControls;

    class function New: ITransacaoTefFactory;
    constructor Create;
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema,
  untTefCitelTransacaoSitefExp, untTefCitelTransacaoSitefExpViewControls,
  untTefCitelTransacaoScope, untTefCitelTransacaoScopeViewControls;

{ TTransacaoTefFactory }

constructor TTransacaoTefFactory.Create;
begin
  FstrCfgTefCit := fCfgSis('TEFCIT');
end;

function TTransacaoTefFactory.fRepository: ITransacaoTefRepository;
begin
  if FstrCfgTefCit = OPCAO_NCR then
    Result := TTransacaoTefRepositoryScope.New
  else if FstrCfgTefCit = OPCAO_CLISITEF then
    Result := TTransacaoTefRepositorySitefExp.New
  else
    Result := nil;
end;

function TTransacaoTefFactory.fViewControls: ITransacaoTefViewControls;
begin
  if FstrCfgTefCit = OPCAO_NCR then
    Result := TTransacaoTefViewControlsScope.New
  else if FstrCfgTefCit = OPCAO_CLISITEF then
    Result := TTransacaoTefViewControlsSitefExp.New
  else
    Result := nil;
end;

class function TTransacaoTefFactory.New: ITransacaoTefFactory;
begin
  Result := Self.Create;
end;

end.
