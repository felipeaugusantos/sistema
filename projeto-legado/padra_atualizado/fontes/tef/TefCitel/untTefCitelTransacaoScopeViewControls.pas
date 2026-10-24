 unit untTefCitelTransacaoScopeViewControls;

interface

uses
  System.SysUtils, untTefCitelTransacaoInterfaces;

type
  TTransacaoTefViewControlsScope = class(TInterfacedObject, ITransacaoTefViewControls)
  public
    function fColunasGrid: TArray<string>;
    function fDiasLimiteBusca: Integer;
    function fTiposBuscaPermitidos: TArray<TTransacaoTefBuscaTipo>;
    function fParamsBusca(const ATipo: TTransacaoTefBuscaTipo): TArray<string>;

    class function New: ITransacaoTefViewControls;
  end;

implementation

{ TTransacaoTefViewControlsScope }

function TTransacaoTefViewControlsScope.fColunasGrid: TArray<string>;
begin
  Result := TArray<string>.Create('INFTRN', 'DTAHRA', 'NUMPDV', 'NUMNSU', 'CONTRO', 'VALTRN', 'ESTADO', 'NUMCAR', 'QTDPAR', 'NOMRED', 'NOMBAN', 'CODAUT', 'NSUHOS');
end;

function TTransacaoTefViewControlsScope.fDiasLimiteBusca: Integer;
begin
  Result := 1;
end;

function TTransacaoTefViewControlsScope.fParamsBusca(
  const ATipo: TTransacaoTefBuscaTipo): TArray<string>;
begin
  case ATipo of
    tbTodas      : Result := TArray<string>.Create('DTATRN');
    tbPendentes  : Result := TArray<string>.Create('DTATRN');
    tbEspecifica : Result := TArray<string>.Create('DTATRN', 'NUMNSU', 'NUMCAR', 'NUMAUT');
    else           Result := TArray<string>.Create();
  end;
end;

function TTransacaoTefViewControlsScope.fTiposBuscaPermitidos: TArray<TTransacaoTefBuscaTipo>;
begin
  Result := TArray<TTransacaoTefBuscaTipo>.Create(tbTodas, tbPendentes, tbEspecifica);
end;

class function TTransacaoTefViewControlsScope.New: ITransacaoTefViewControls;
begin
  Result := Self.Create;
end;

end.
