unit untTefCitelTransacaoSitefExpViewControls;

interface

uses
  System.SysUtils, untTefCitelTransacaoInterfaces;

type
  TTransacaoTefViewControlsSitefExp = class(TInterfacedObject, ITransacaoTefViewControls)
  public
    function fColunasGrid: TArray<string>;
    function fDiasLimiteBusca: Integer;
    function fTiposBuscaPermitidos: TArray<TTransacaoTefBuscaTipo>;
    function fParamsBusca(const ATipo: TTransacaoTefBuscaTipo): TArray<string>;

    class function New: ITransacaoTefViewControls;
  end;

implementation

{ TTransacaoTefViewControlsSitefExp }

function TTransacaoTefViewControlsSitefExp.fColunasGrid: TArray<string>;
begin
  Result := TArray<string>.Create('INFTRN', 'TIPTRN', 'DTAHRA', 'NSUHOS', 'CODSIT', 'VALTRN', 'ESTADO');
end;

function TTransacaoTefViewControlsSitefExp.fDiasLimiteBusca: Integer;
begin
  Result := 0;
end;

function TTransacaoTefViewControlsSitefExp.fParamsBusca(const ATipo: TTransacaoTefBuscaTipo): TArray<string>;
begin
  case ATipo of
    tbTodas      : Result := TArray<string>.Create('DTATRN');
    tbPendentes  : Result := TArray<string>.Create('DTAINI', 'DTAFIN');
    tbEspecifica : Result := TArray<string>.Create('DTATRN', 'CODLOJ', 'NUMNSU', 'CODSIT');
    else           Result := TArray<string>.Create();
  end;
end;

function TTransacaoTefViewControlsSitefExp.fTiposBuscaPermitidos: TArray<TTransacaoTefBuscaTipo>;
begin
  Result := TArray<TTransacaoTefBuscaTipo>.Create(tbTodas, tbPendentes);
end;

class function TTransacaoTefViewControlsSitefExp.New: ITransacaoTefViewControls;
begin
  Result := Self.Create;
end;

end.
