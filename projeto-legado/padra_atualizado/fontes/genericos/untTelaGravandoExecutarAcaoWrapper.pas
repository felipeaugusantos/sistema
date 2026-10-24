unit untTelaGravandoExecutarAcaoWrapper;

interface

uses
  untITelaGravando, untITelaGravandoExecucao, cxProgressBar,
  StdCtrls, Forms, StrUtils;

type
  TTelaGravandoExecutarAcaoWrapper = class(TInterfacedObject, ITelaGravando)
  private
    executor: ITelaGravandoExecucao;
    lblGravando: TLabel;
    pgbProgresso: TcxProgressBar;
  public
    constructor Create(const executor: ITelaGravandoExecucao);
    function Executar(pgbProgresso: TcxProgressBar): Boolean;
    function GetTexto: string;
    procedure RegistrarProgresso(const intInicio: Integer; const intAtual: Integer; const intFinal: Integer);
    procedure SetTexto(const strTexto: string);
  end;

implementation

{ TTelaGravandoExecutarAcaoWrapper }

constructor TTelaGravandoExecutarAcaoWrapper.Create(const executor: ITelaGravandoExecucao);
begin
  inherited Create();
  Self.executor := executor;
  Self.lblGravando := nil;
  Self.pgbProgresso := nil;
end;

function TTelaGravandoExecutarAcaoWrapper.Executar(pgbProgresso: TcxProgressBar): Boolean;
begin
  Self.lblGravando := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));
  Self.pgbProgresso := pgbProgresso;
  Self.executor.Executar(Self);
  Result := True;
end;

function TTelaGravandoExecutarAcaoWrapper.GetTexto: string;
begin
  Result := '';
  if Assigned(lblGravando) then
    Result := lblGravando.Caption;
end;

procedure TTelaGravandoExecutarAcaoWrapper.RegistrarProgresso(const intInicio, intAtual, intFinal: Integer);
begin
  if Assigned(pgbProgresso) then
  begin
    pgbProgresso.Properties.Max := intFinal;
    pgbProgresso.Properties.Min := intInicio;
    pgbProgresso.Position := intAtual;
  end;
  Application.ProcessMessages;
end;

procedure TTelaGravandoExecutarAcaoWrapper.SetTexto(const strTexto: string);
const
  intTamanhoMaximo: Integer = 50;
begin
  if Assigned(lblGravando) then
  begin
    if Length(strTexto) > intTamanhoMaximo then
      lblGravando.Caption := LeftStr(strTexto, intTamanhoMaximo - 3) + '...'
    else
      lblGravando.Caption := strTexto;

  end;

end;

end.
